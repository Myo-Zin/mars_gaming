import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/date_state.dart';
import '../../../utils/failure.dart';
import '../../auth/providers/providers.dart';

import '../repositories/cash_in_out_history_repository.dart';
import 'cash_out_history_state.dart';

class CashOutHistoryNotifier extends StateNotifier<CashOutHistoryState> {
  final Ref ref;
  final DateState dateState;
  final CashInOutHistoryRepository repository;

  CashOutHistoryNotifier(
    this.ref,
    this.dateState,
    this.repository,
  ) : super(const CashOutHistoryState.empty()) {
    if (!dateState.isEmpty) {
      getCashOutHistory(dateState);
    }
  }

  Future<void> getCashOutHistory(DateState ds) async {
    state = const CashOutHistoryState.loading();
    final result = await repository.getCashOutHistory(ds);
    if (mounted) {
      result.fold(
        (failture) {
          if (failture.reason == FailureReason.authError) {
            ref.read(authControllerProvider.notifier).logout();
          }
          if (mounted) {
            state = CashOutHistoryState.error(failture.message);
          }
        },
        (list) {
          state = CashOutHistoryState.data(list);
        },
      );
    }
    if (mounted) {
      state = result.fold(
        (failture) => CashOutHistoryState.error(failture.message),
        (list) => CashOutHistoryState.data(list),
      );
    }
  }
}
