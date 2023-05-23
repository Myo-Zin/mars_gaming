import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/three_d_section.dart';
import '../repositories/three_d_repository.dart';


class ThreeDSectionNotifier extends StateNotifier<AsyncValue<void>> {
  ThreeDSectionNotifier(this.repository) : super(const AsyncData(null));
  final ThreeDRepository repository;

  Future<ThreeDSection?> getSection() async {
    state = const AsyncLoading();
    final result = await repository.getThreeDSection();
    return result.fold(
      (l) {
        state = AsyncError(l.message, StackTrace.empty);
        return null;
      },
      (r) {
        state = const AsyncData(null);
        return r;
      },
    );
  }
}
