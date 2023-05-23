import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/hot_new_game_response.dart';
import '../repositories/games_repository.dart';


class HotNewGamesNotifier extends StateNotifier<AsyncValue<List<HotNewGame>>> {
  final GameRepository gameRepository;
  HotNewGamesNotifier(this.gameRepository) : super(const AsyncLoading()) {
    getGames();
  }

  Future<void> getGames() async {
    final result = await gameRepository.getHotNewGames();

    state = result.fold(
      (l) => AsyncError(l.message, StackTrace.empty),
      (r) => AsyncData(r),
    );
  }
}
