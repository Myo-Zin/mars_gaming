import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/referral_repository.dart';

class ClaimReferralNotifier extends StateNotifier<AsyncValue<void>> {
  final Ref ref;
  final ReferralHistoryRepository repository;

  ClaimReferralNotifier(this.ref, this.repository)
      : super(const AsyncData(null));

  Future<bool> claimReferAmount(String token) async {
    state = const AsyncLoading();
    final result = await repository.claimReferAmount(token);

    return result.fold(
      (l) {
        if (mounted) {
          state = AsyncError(l.message, StackTrace.empty);
        }

        return false;
      },
      (r) {
        if (mounted) {
          state = const AsyncData(null);
        }
        return true;
      },
    );
  }
}
