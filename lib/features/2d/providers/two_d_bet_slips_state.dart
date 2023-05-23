import 'package:freezed_annotation/freezed_annotation.dart';


import '../models/two_d_bet_slips_history_response.dart';

part 'two_d_bet_slips_state.freezed.dart';

@freezed
class TwoDBetSlipState with _$TwoDBetSlipState {
  const factory TwoDBetSlipState.empty() = _Empty;
  const factory TwoDBetSlipState.loading() = _Loading;
  const factory TwoDBetSlipState.data(
      List<BetSlip> betSlips) = _Data;
  const factory TwoDBetSlipState.error(String message) = _Error;
}
