
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/date_state.dart';
import '../../../utils/failure.dart';
import '../../auth/providers/providers.dart';
import '../repositories/crypto_two_d_repository.dart';
import 'crypto_two_d_lucky_num_history_state.dart';

class CryptoTwoDLuckyNumberHistoryNotifier
    extends StateNotifier<CryptoTwoDLuckyNumHistoryState> {
  final Ref ref;
  final CryptoTwoDRepository cryptoTwoDRepository;
  final DateState dateState;

  CryptoTwoDLuckyNumberHistoryNotifier(
      this.ref,
      this.cryptoTwoDRepository,
      this.dateState,
      ) : super(const CryptoTwoDLuckyNumHistoryState.empty()) {
    if (!dateState.isEmpty) {
      getTwoDLuckyNumberHistory(dateState);
    }
  }

  Future<void> getTwoDLuckyNumberHistory(DateState ds) async {
    state = const CryptoTwoDLuckyNumHistoryState.loading();
    final result = await cryptoTwoDRepository.getCryptoTowDLuckyNumberHistory(ds);
    if (mounted) {
      result.fold(
            (failure) {
          if (failure.reason == FailureReason.authError) {
            ref.read(authControllerProvider.notifier).logout();
          }
          if (mounted) {
            state = CryptoTwoDLuckyNumHistoryState.error(failure.message);
          }
        },
            (list) {
          state = CryptoTwoDLuckyNumHistoryState.data(list);
        },
      );
    }
    }

}
