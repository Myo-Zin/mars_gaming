import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/two_d_lucky_number.dart';
import '../repositories/two_d_repository.dart';


class TwoDDailyLuckyNumberNotifier
    extends StateNotifier<AsyncValue<List<TwoDLuckyNumber>>> {
  TwoDDailyLuckyNumberNotifier(this.repository) : super(const AsyncLoading()) {
    getDailyLuckyNumbers();
  }
  final TwoDRepository repository;

  Future<void> getDailyLuckyNumbers() async {
    final result = await repository.getTwoDLuckyNumberDailyList();
    state = result.fold(
      (l) => AsyncError(l.message, StackTrace.empty),
      (r) => AsyncData(r),
    );
  }
}
