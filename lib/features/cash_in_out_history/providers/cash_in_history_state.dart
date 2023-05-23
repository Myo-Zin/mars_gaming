import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/cash_in_history_response.dart';

part 'cash_in_history_state.freezed.dart';

@freezed
class CashInHistoryState with _$CashInHistoryState {
  const factory CashInHistoryState.empty() = _Empty;
  const factory CashInHistoryState.loading() = _Loading;
  const factory CashInHistoryState.data(List<CashInHistory> cashInHistories) =
      _Data;
  const factory CashInHistoryState.error(String message) = _Error;
}
