import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/three_d_bet_slip.dart';


part 'three_d_bet_slips_state.freezed.dart';

@freezed
class ThreeDBetSlipState with _$ThreeDBetSlipState {
  const factory ThreeDBetSlipState.empty() = _Empty;
  const factory ThreeDBetSlipState.loading() = _Loading;
  const factory ThreeDBetSlipState.data(
      List<ThreeDBetSlip> threeDBetSlip) = _Data;
  const factory ThreeDBetSlipState.error(String message) = _Error;
}