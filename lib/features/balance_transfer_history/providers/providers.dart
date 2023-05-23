import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/date_controller.dart';
import '../../../core/providers/dio_provider.dart';
import '../repositories/balance_transfer_history_repository.dart';
import '../services/balance_transfer_history_service.dart';
import 'balance_transfer_history_controller.dart';
import 'balance_transfer_history_state.dart';

final balanceTransferHistoryServiceProvider =
    Provider((ref) => BalanceTransferHistoryService(ref.read(dioProvider)));

final balanceTransferHistoryRepositoryProvider = Provider((ref) =>
    BalanceTransferHistoryRepository(
        ref.read(balanceTransferHistoryServiceProvider)));

final balanceTransferHistoryControllerProvider =
    StateNotifierProvider.autoDispose.family<BalanceTransferHistoryNotifier,
        BalanceTransferHistoryState, BalanceTransferType>((ref, type) {
  final dateState = ref.watch(dateController);
  return BalanceTransferHistoryNotifier(
    type: type,
    dateState: dateState,
    repository: ref.read(balanceTransferHistoryRepositoryProvider),
  );
});
