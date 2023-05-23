import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/sharepref.dart';
import '../models/auth_state.dart';
import '../repository/auth_repository.dart';
import 'providers.dart';


class LoginScreenController extends StateNotifier<AsyncValue<void>> {
  final Ref ref;
  final AuthRepository _authRepository;

  LoginScreenController(
    this.ref,
    this._authRepository,
  ) : super(const AsyncData(null));

  Future<bool> login({
    required int phone,
    required String password,
  }) async {
    state = const AsyncLoading();
    final result = await _authRepository.login(
      phone: phone,
      password: password,
    );

    return result.fold(
      (l) {
        state = AsyncValue.error(
          l.message,
          StackTrace.empty,
        );
        ref
            .read(authControllerProvider.notifier)
            .changeAuth(const AuthState.unAuthenticated());
        return false;
      },
      (r) {
        SharePref.setAuth(r);
        state = const AsyncData(null);
        ref
            .read(authControllerProvider.notifier)
            .changeAuth(AuthState.authenticated(r));
        return true;
      },
    );
  }
}
