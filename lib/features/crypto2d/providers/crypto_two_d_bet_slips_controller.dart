import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/date_state.dart';
import '../../../utils/failure.dart';
import '../../auth/providers/providers.dart';
import '../repositories/crypto_two_d_repository.dart';
import 'crypto_two_d_bet_slips_state.dart';

class CryptoTwoDBetSlipsNotifier extends StateNotifier<CryptoTwoDBetSlipState> {
  final Ref ref;
  final DateState dateState;
  final CryptoTwoDRepository repository;

  CryptoTwoDBetSlipsNotifier(
    this.ref,
    this.repository,
    this.dateState,
  ) : super(const CryptoTwoDBetSlipState.empty()) {
    if (!dateState.isEmpty) {
      getTwoDBetSlipHistory(dateState);
    }
  }

  Future<void> getTwoDBetSlipHistory(DateState ds) async {
    state = const CryptoTwoDBetSlipState.loading();
    final result = await repository.getCryptoTwoDBetSlipHistory(ds);
    if (mounted) {
      result.fold(
        (failure) {
          if (failure.reason == FailureReason.authError) {
            ref.read(authControllerProvider.notifier).logout();
          }
          if (mounted) {
            state = CryptoTwoDBetSlipState.error(failure.message);
          }
        },
        (list) {
          state = CryptoTwoDBetSlipState.data(list);
        },
      );
    }
  }
}
