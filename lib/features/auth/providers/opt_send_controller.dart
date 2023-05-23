import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/route.dart';
import '../../../utils/sharepref.dart';
import '../models/auth_state.dart';
import '../models/registeration_form.dart';
import '../pages/change_password_page.dart';
import '../pages/code_verify_page.dart';
import '../repository/auth_repository.dart';

class OTPSendNotifier extends StateNotifier<AsyncValue<void>> {
  final Ref ref;
  final AuthRepository _authRepository;
  String phone;

  // final FirebaseAuth _firebaseAuth;

  OTPSendNotifier(this.ref, this._authRepository, this.phone)
      : super(const AsyncData(null)) {
    sendOTP(phone: phone);
  }

  Future<bool> sendOTP({
    required String phone,
  }) async {
    state = const AsyncLoading();
    final result = await _authRepository.optSend(
      phone: phone,
    );

    return result.fold(
      (l) {
        state = AsyncValue.error(
          l.message,
          StackTrace.empty,
        );
        return false;
      },
      (r) {
        state = const AsyncData(null);
        return true;
      },
    );
  }
}
