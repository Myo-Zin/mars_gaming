import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mars_gaming/features/referral/providers/referral_state.dart';

import '../../../core/providers/date_controller.dart';
import '../../../core/providers/dio_provider.dart';
import '../repositories/referral_repository.dart';
import '../service/referral_service.dart';
import 'claim_referral_amount_controller.dart';
import 'referral_controller.dart';

final referralServiceProvider =
    Provider((ref) => ReferralService(ref.read(dioProvider)));

final referralRepositoryProvider = Provider(
    (ref) => ReferralHistoryRepository(ref.read(referralServiceProvider)));

final referralController =
    StateNotifierProvider.autoDispose<ReferralNotifier, ReferralState>((ref) {
  final dateState = ref.watch(dateController);
  return ReferralNotifier(
    ref,
    ref.watch(referralRepositoryProvider),
    dateState,
  );
});

final claimReferralController =
StateNotifierProvider.autoDispose<ClaimReferralNotifier, AsyncValue<void>>((ref) {
  return ClaimReferralNotifier(ref,ref.watch(referralRepositoryProvider));
});
