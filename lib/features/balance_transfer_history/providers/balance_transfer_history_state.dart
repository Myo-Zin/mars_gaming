import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/balance_transfer_history_response.dart';

part 'balance_transfer_history_state.freezed.dart';

@freezed
class BalanceTransferHistoryState with _$BalanceTransferHistoryState {
  const factory BalanceTransferHistoryState.empty() = _Empty;
  const factory BalanceTransferHistoryState.loading() = _Loading;
  const factory BalanceTransferHistoryState.data(
      List<BalanceTransferHistory> balanceTransferHistories) = _Data;
  const factory BalanceTransferHistoryState.error(String message) = _Error;
}
