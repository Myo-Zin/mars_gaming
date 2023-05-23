import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/cash_out_history_response.dart';

part 'cash_out_history_state.freezed.dart';

@freezed
class CashOutHistoryState with _$CashOutHistoryState {
  const factory CashOutHistoryState.empty() = _Empty;
  const factory CashOutHistoryState.loading() = _Loading;
  const factory CashOutHistoryState.data(
      List<CashOutHistory> cashOutHistories) = _Data;
  const factory CashOutHistoryState.error(String message) = _Error;
}
