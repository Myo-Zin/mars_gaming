import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mars_gaming/features/3d/providers/three_d_lucky_number_state.dart';

import '../../../core/providers/date_state.dart';
import '../../../utils/failure.dart';
import '../../auth/providers/providers.dart';
import '../repositories/three_d_repository.dart';

class ThreeDLuckyNumberHistoryNotifier
    extends StateNotifier<ThreeDLuckyNumHistoryState> {
  final Ref ref;
  final ThreeDRepository threeDRepository;
  final DateState dateState;

  ThreeDLuckyNumberHistoryNotifier(
    this.ref,
    this.threeDRepository,
    this.dateState,
  ) : super(const ThreeDLuckyNumHistoryState.empty()) {
    if (!dateState.isEmpty) {
      getThreeDLuckyNumberHistory(dateState);
    }
  }

  Future<void> getThreeDLuckyNumberHistory(DateState ds) async {
    state = const ThreeDLuckyNumHistoryState.loading();
    final result = await threeDRepository.getThreeDLuckyNumHistory(ds);
    if (mounted) {
      result.fold(
        (failure) {
          if (failure.reason == FailureReason.authError) {
            ref.read(authControllerProvider.notifier).logout();
          }
          if (mounted) {
            state = ThreeDLuckyNumHistoryState.error(failure.message);
          }
        },
        (list) {
          state = ThreeDLuckyNumHistoryState.data(list);
        },
      );
    }
  }
}
