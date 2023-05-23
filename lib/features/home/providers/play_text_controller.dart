import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/play_text_response.dart';
import '../repositories/home_repository.dart';

class PlayTextNotifier extends StateNotifier<AsyncValue<List<PlayText>>> {
  final HomeRepository homeRepository;
  PlayTextNotifier(this.homeRepository) : super(const AsyncLoading()) {
    getPlayText();
  }

  Future<void> getPlayText() async {
    final result = await homeRepository.getPlayText();
    state = result.fold(
      (l) => AsyncError(l.message, StackTrace.empty),
      (r) => AsyncData(r),
    );
  }
}
