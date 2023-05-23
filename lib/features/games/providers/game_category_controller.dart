import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/game_category_response.dart';
import '../repositories/games_repository.dart';


class GameCategoryNotifier
    extends StateNotifier<AsyncValue<List<GameCategory>>> {
  final String url;
  final GameRepository gameRepository;
  GameCategoryNotifier(this.url, this.gameRepository)
      : super(const AsyncLoading()) {
    getGames(url);
  }

  Future<void> getGames(String url) async {
    final result = await gameRepository.getGameCategory(url);

    state = result.fold(
      (l) => AsyncError(l.message, StackTrace.empty),
      (r) => AsyncData(r),
    );
  }
}
