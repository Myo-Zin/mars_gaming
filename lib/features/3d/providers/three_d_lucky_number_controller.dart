import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/Three_d_lucky_number.dart';
import '../repositories/three_d_repository.dart';

class ThreeDLuckyNumberNotifier
    extends StateNotifier<AsyncValue<List<ThreeDLuckyNumber>>> {
  ThreeDLuckyNumberNotifier(this.repository) : super(const AsyncLoading()) {
    getLuckyNumbers();
  }

  final ThreeDRepository repository;

  Future<void> getLuckyNumbers() async {
    final result = await repository.getThreeDLuckyNumberList();
    state = result.fold(
      (l) => AsyncError(l.message, StackTrace.empty),
      (r) => AsyncData(r),
    );
  }
}
