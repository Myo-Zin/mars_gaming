import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mars_gaming/features/3d/providers/three_d_bet_slips_state.dart';
import '../../../core/providers/date_state.dart';
import '../../../utils/failure.dart';
import '../../auth/providers/providers.dart';

import '../repositories/three_d_repository.dart';

class ThreeDBetSlipsNotifier extends StateNotifier<ThreeDBetSlipState> {
  final Ref ref;
  final DateState dateState;
  final ThreeDRepository repository;

  ThreeDBetSlipsNotifier(
      this.ref,
      this.repository,
      this.dateState,
      ) : super(const ThreeDBetSlipState.empty()) {
    if (!dateState.isEmpty) {
      getThreeDBetSlipHistory(dateState);
    }
  }

  Future<void> getThreeDBetSlipHistory(DateState ds) async {
    state = const ThreeDBetSlipState.loading();
    final result = await repository.getThreeDBetSlipHistory(ds);
    if (mounted) {
      result.fold(
            (failure) {
          if (failure.reason == FailureReason.authError) {
            ref.read(authControllerProvider.notifier).logout();
          }
          if (mounted) {
            state = ThreeDBetSlipState.error(failure.message);
          }
        },
            (list) {
          state = ThreeDBetSlipState.data(list);
        },
      );
    }
  }
}