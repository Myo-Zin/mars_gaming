import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/game_response.dart';
import '../repositories/games_repository.dart';


class GamesNotifier extends StateNotifier<AsyncValue<List<Game>>> {
  final String url;
  final GameRepository gameRepository;
  GamesNotifier(this.url, this.gameRepository) : super(const AsyncLoading()) {
    getGames(url);
  }

  Future<void> getGames(String url) async {
    final result = await gameRepository.getGames(url);

    state = result.fold(
      (l) => AsyncError(l.message, StackTrace.empty),
      (r) => AsyncData(r),
    );
  }
}
