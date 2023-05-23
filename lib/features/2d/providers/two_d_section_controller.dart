import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/two_d_section.dart';
import '../repositories/two_d_repository.dart';

class TwoDSectionNotifier extends StateNotifier<AsyncValue<List<TwoDSection>>> {
  TwoDSectionNotifier(this.repository) : super(const AsyncLoading()) {
    getTwoDSection();
  }
  final TwoDRepository repository;

  Future<void> getTwoDSection() async {
    final result = await repository.getTwoDSectionList();
    state = result.fold(
      (l) => AsyncError(l.message, StackTrace.empty),
      (r) => AsyncData(r),
    );
  }
}
