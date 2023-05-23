import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../models/two_d.dart';
import '../repositories/two_d_repository.dart';

class TwoDBetNotifier extends StateNotifier<AsyncValue<void>> {
  TwoDBetNotifier(this.repository) : super(const AsyncData(null));
  final TwoDRepository repository;

  Future<bool> bet({
    required List<TwoD> twoDList,
    required String section,
    required String token,
  }) async {
    state = const AsyncLoading();
    final result = await repository.betTwoD(
      twoDList: twoDList,
      section: section,
      token: token,
    );
    return result.fold(
      (l) {
        state = AsyncError(l.message, StackTrace.empty);
        return false;
      },
      (r) {
        state = const AsyncData(null);
        return true;
      },
    );
  }
}
