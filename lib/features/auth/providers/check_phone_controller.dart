
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/auth_repository.dart';

class CheckPhoneNotifier extends StateNotifier<AsyncValue<void>> {
  final Ref ref;
  final AuthRepository _authRepository;

  // final FirebaseAuth _firebaseAuth;

  CheckPhoneNotifier(this.ref, this._authRepository)
      : super(const AsyncData(null));

  Future<String?> checkPhone({
    required String phone,
  }) async {
    state = const AsyncLoading();
    final result = await _authRepository.checkPhone(
      phone: phone,
    );

    return result.fold(
          (l) {
        state = AsyncValue.error(
          l.message,
          StackTrace.empty,
        );
        return null;
      },
          (r) {
        state = const AsyncData(null);
        return r;
      },
    );
  }
}