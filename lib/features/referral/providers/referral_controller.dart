import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/date_state.dart';
import '../../../utils/failure.dart';
import '../../auth/providers/providers.dart';
import '../repositories/referral_repository.dart';
import 'referral_state.dart';

class ReferralNotifier extends StateNotifier<ReferralState> {
  final Ref ref;
  final DateState dateState;
  final ReferralHistoryRepository repository;

  ReferralNotifier(
    this.ref,
    this.repository,
    this.dateState,
  ) : super(const ReferralState.empty()) {
    if (!dateState.isEmpty) {
      getReferralHistory(dateState);
    }
  }

  Future<void> getReferralHistory(DateState ds) async {
    state = const ReferralState.loading();
    final result = await repository.getReferralHistoryList(ds);
    if (mounted) {
      result.fold(
        (failure) {
          if (failure.reason == FailureReason.authError) {
            ref.read(authControllerProvider.notifier).logout();
          }
          if (mounted) {
            state = ReferralState.error(failure.message);
          }
        },
        (list) {
          state = ReferralState.data(list);
        },
      );
    }
  }

}
