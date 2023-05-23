
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/winnner_response.dart';
import '../repository/winner_repository.dart';

class WinnerNotifier extends StateNotifier<AsyncValue<List<Winner>>> {
  final String url;
  final WinnerRepository gameRepository;
  WinnerNotifier(this.url, this.gameRepository) : super(const AsyncLoading()) {
    getWinner(url);
  }

  Future<void> getWinner(String url) async {
    final result = await gameRepository.getWinnerList(url);

    state = result.fold(
          (l) => AsyncError(l.message, StackTrace.empty),
          (r) => AsyncData(r),
    );
  }
}
