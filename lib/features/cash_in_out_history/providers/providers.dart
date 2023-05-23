import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../../core/providers/date_controller.dart';
import '../../../core/providers/dio_provider.dart';
import '../repositories/cash_in_out_history_repository.dart';
import '../services/cash_in_out_history_service.dart';
import 'cash_in_history_controller.dart';
import 'cash_in_history_state.dart';
import 'cash_out_history_controller.dart';
import 'cash_out_history_state.dart';

final cashInOutHistoryServiceProvider =
    Provider((ref) => CashInOutHistoryService(ref.read(dioProvider)));

final cashInOutHistoryRepositoryProvider = Provider((ref) =>
    CashInOutHistoryRepository(ref.read(cashInOutHistoryServiceProvider)));

final cashOutHistoryControllerProvider = StateNotifierProvider.autoDispose<
    CashOutHistoryNotifier, CashOutHistoryState>((ref) {
  final dateState = ref.watch(dateController);
  return CashOutHistoryNotifier(
    ref,
    dateState,
    ref.read(
      cashInOutHistoryRepositoryProvider,
    ),
  );
});

final cashInHistoryControllerProvider = StateNotifierProvider.autoDispose<
    CashInHistoryNotifier, CashInHistoryState>((ref) {
  final dateState = ref.watch(dateController);
  return CashInHistoryNotifier(
    ref,
    dateState,
    ref.read(
      cashInOutHistoryRepositoryProvider,
    ),
  );
});
