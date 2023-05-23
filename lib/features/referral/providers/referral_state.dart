
import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/referral_history_response.dart';

part 'referral_state.freezed.dart';

@freezed
class ReferralState with _$ReferralState {
  const factory ReferralState.empty() = _Empty;
  const factory ReferralState.loading() = _Loading;
  const factory ReferralState.data(
      List<ReferralHistoryData> referralHistory) = _Data;
  const factory ReferralState.error(String message) = _Error;
}