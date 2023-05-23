import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/sharepref.dart';
import '../models/auth_state.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState.unAuthenticated());

  void getAuth() async {
    final token = await SharePref.getAuth();
    if (token == null) {
      state = const AuthState.unAuthenticated();
    } else {
      state = AuthState.authenticated(token);
    }
  }

  void logout() {
    state = const AuthState.unAuthenticated();
    SharePref.clear();
  }

  void changeAuth(AuthState authState) {
    state = authState;
  }
}
