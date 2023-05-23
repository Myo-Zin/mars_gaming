import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../models/three_d.dart';
import '../models/three_d_section.dart';
import '../repositories/three_d_repository.dart';

class ThreeDBetNotifier extends StateNotifier<AsyncValue<void>> {
  ThreeDBetNotifier(this.repository) : super(const AsyncData(null));
  final ThreeDRepository repository;

  Future<bool> bet({
    required List<ThreeD> threeDList,
    required ThreeDSection section,
    required String token,
  }) async {
    state = const AsyncLoading();
    final result = await repository.betThreeD(
      threeDList: threeDList,
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