import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/date_state.dart';
import '../../../utils/failure.dart';
import '../../auth/providers/providers.dart';

import '../repositories/two_d_repository.dart';
import 'two_d_bet_slips_state.dart';

class TwoDBetSlipsNotifier extends StateNotifier<TwoDBetSlipState> {
  final Ref ref;
  final DateState dateState;
  final TwoDRepository repository;

  TwoDBetSlipsNotifier(
    this.ref,
    this.repository,
    this.dateState,
  ) : super(const TwoDBetSlipState.empty()) {
    if (!dateState.isEmpty) {
      getTwoDBetSlipHistory(dateState);
    }
  }

  Future<void> getTwoDBetSlipHistory(DateState ds) async {
    state = const TwoDBetSlipState.loading();
    final result = await repository.getTwoDBetSlipHistory(ds);
    if (mounted) {
      result.fold(
        (failture) {
          if (failture.reason == FailureReason.authError) {
            ref.read(authControllerProvider.notifier).logout();
          }
          if (mounted) {
            state = TwoDBetSlipState.error(failture.message);
          }
        },
        (list) {
          state = TwoDBetSlipState.data(list);
        },
      );
    }
  }
}
