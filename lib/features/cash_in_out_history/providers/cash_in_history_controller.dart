import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/date_state.dart';
import '../../../utils/failure.dart';
import '../../auth/providers/providers.dart';

import '../repositories/cash_in_out_history_repository.dart';
import 'cash_in_history_state.dart';

class CashInHistoryNotifier extends StateNotifier<CashInHistoryState> {
  final Ref ref;
  final DateState dateState;
  final CashInOutHistoryRepository repository;

  CashInHistoryNotifier(this.ref, this.dateState, this.repository)
      : super(const CashInHistoryState.empty()) {
    if (!dateState.isEmpty) {
      getCashInHistory(dateState);
    }
  }

  Future<void> getCashInHistory(DateState ds) async {
    state = const CashInHistoryState.loading();
    final result = await repository.getCashInHistory(ds);
    if (mounted) {
      result.fold(
        (failture) {
          if (failture.reason == FailureReason.authError) {
            ref.read(authControllerProvider.notifier).logout();
          }
          if (mounted) {
            state = CashInHistoryState.error(failture.message);
          }
        },
        (list) {
          state = CashInHistoryState.data(list);
        },
      );
    }
  }
}
