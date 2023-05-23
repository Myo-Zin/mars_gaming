import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/enum.dart';
import '../../../core/providers/date_controller.dart';
import '../../../core/providers/dio_provider.dart';
import '../../../utils/url_constants.dart';
import '../models/game_category_response.dart';
import '../models/game_report_detail.dart';
import '../models/game_report_detail_param.dart';
import '../models/game_response.dart';
import '../models/games_by_id_param.dart';
import '../models/hot_new_game_response.dart';
import '../repositories/games_repository.dart';
import '../services/game_api_service.dart';
import 'game_category_controller.dart';
import 'game_report_controller.dart';
import 'game_report_detail_controller.dart';
import 'game_report_state.dart';
import 'game_view_controller.dart';
import 'games_controller.dart';
import 'hot_new_games_controller.dart';
import 'search_games_by_category_id_controller.dart';

final gameServiceProvider =
    Provider((ref) => GameApiService(ref.read(dioProvider)));

final gameRepositoryProvider =
    Provider((ref) => GameRepository(ref.read(gameServiceProvider)));

final gameControllerProvider = StateNotifierProvider.family<GamesNotifier,
    AsyncValue<List<Game>>, GameType>(
  (ref, type) => GamesNotifier(
    UrlConst.getGamesUrl(type),
    ref.read(gameRepositoryProvider),
  ),
);
final hotNewGameControllerProvider =
    StateNotifierProvider<HotNewGamesNotifier, AsyncValue<List<HotNewGame>>>(
  (ref) => HotNewGamesNotifier(
    ref.read(gameRepositoryProvider),
  ),
);

final gameCategoryControllerProvider = StateNotifierProvider.family<
    GameCategoryNotifier, AsyncValue<List<GameCategory>>, GameType>(
  (ref, gameType) => GameCategoryNotifier(
    UrlConst.getGameCategoryUrl(gameType),
    ref.read(gameRepositoryProvider),
  ),
);

final searchTextEditingControllerProvider = StateProvider.family
    .autoDispose<TextEditingController, GameType>(
  (ref, param) => TextEditingController(),
);

final gamesByCategoryIdProvider =
    Provider.family.autoDispose<List<Game>, GameByCategoryIdParam>(
  (ref, param) {
    final games = ref.watch(gameControllerProvider(param.gameType));
    return games.maybeWhen(
      data: (data) {
        if (param.categoryId == null) {
          return data;
        }
        return data.where((e) => e.providerId == param.categoryId).toList();
      },
      orElse: () => <Game>[],
    );
  },
);
final searchGamesByCategoryIdProvider = StateNotifierProvider.family
    .autoDispose<SearchGamesByCategoryIdNotifier, List<Game>,
        GameByCategoryIdParam>(
  (ref, param) {
    final games = ref.watch(gamesByCategoryIdProvider(param));
    return SearchGamesByCategoryIdNotifier(ref, param, games);
  },
);

final selectedCategoryNotifier =
    StateProvider.family.autoDispose<int?, GameType>((ref, gameType) => null);

final gameViewController =
    StateNotifierProvider<GameViewNotifier, AsyncValue<String?>>(
  (ref) => GameViewNotifier(
    ref.watch(gameRepositoryProvider),
    ref,
  ),
);

final gameReportController =
    StateNotifierProvider.autoDispose<GameReportNotifier, GameReportState>(
        (ref) {
  final ds = ref.watch(dateController);
  return GameReportNotifier(
    ref,
    ref.watch(gameRepositoryProvider),
    ds,
  );
});
final gameReportDetailController = StateNotifierProvider.family.autoDispose<
    GameReportDetailNotifier,
    AsyncValue<List<GameReportDetail>>,
    GameReportDetailParam>((ref, param) {
  return GameReportDetailNotifier(
    ref.watch(gameRepositoryProvider),
    param,
  );
});
