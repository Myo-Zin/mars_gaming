import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/crypto_two_d_bet_slips_history_response.dart';


part 'crypto_two_d_bet_slips_state.freezed.dart';

@freezed
class CryptoTwoDBetSlipState with _$CryptoTwoDBetSlipState {
  const factory CryptoTwoDBetSlipState.empty() = _Empty;
  const factory CryptoTwoDBetSlipState.loading() = _Loading;
  const factory CryptoTwoDBetSlipState.data(List<BetSlip> betSlips) = _Data;
  const factory CryptoTwoDBetSlipState.error(String message) = _Error;
}
