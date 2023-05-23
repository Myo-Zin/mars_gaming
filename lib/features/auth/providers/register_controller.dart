import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mars_gaming/features/auth/providers/providers.dart';

import '../../../utils/route.dart';
import '../../../utils/sharepref.dart';
import '../models/auth_state.dart';
import '../models/otp_response.dart';
import '../models/registeration_form.dart';
import '../pages/change_password_page.dart';
import '../pages/code_verify_page.dart';
import '../repository/auth_repository.dart';

class RegisterScreenController extends StateNotifier<AsyncValue<void>> {
  final Ref ref;
  final AuthRepository _authRepository;

  final FirebaseAuth _firebaseAuth;

  RegisterScreenController(
    this.ref,
    this._authRepository,
      this._firebaseAuth,
  ) : super(const AsyncData(null));

  verifyPhoneForRegister({
    required RegisterationForm rf,
    required BuildContext context,
  }) {
    _verifyPhone(
      phone: rf.phone,
      context: context,
      callback: (String verificationId) {
        goto(
          context,
          page: CodeVerifyPage(
            phoneForForgotPassword: null,
            registerationForm: rf,
            verificationId: verificationId,
          ),
        );
      },
    );
  }

  verifyPhoneForForgotPassword({
    required String phone,
    required BuildContext context,
  }) {
    _verifyPhone(
      phone: phone,
      context: context,
      callback: (String verificationId) {
        goto(
          context,
          page: CodeVerifyPage(
            phoneForForgotPassword: phone,
            registerationForm: null,
            verificationId: verificationId,
          ),
        );
      },
    );
  }

  Future<void> _verifyPhone({
    required String phone,
    required Function(String verificationId) callback,
    required BuildContext context,
  }) async {
    state = const AsyncLoading();
    _firebaseAuth.verifyPhoneNumber(
      phoneNumber: "+95${int.parse(phone)}",
      verificationCompleted: (phoneAuthCredential) {},
      verificationFailed: (error) {
        state = AsyncError(
            error.message ?? "something went wrong!", StackTrace.empty);
      },
      codeSent: (verificationId, forceResendingToken) {
        log("verification id $verificationId");
        state = const AsyncData(null);
        callback(verificationId);
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
     // <-- here is the magic
  }

  Future<bool> checkCodeForRegister({
    required String verificationId,
    required String smsCode,
    required RegisterationForm rf,
  }) async {
    return _checkCode(
      verificationId: verificationId,
      smsCode: smsCode,
      callback: () {
        register(rf: rf);
      },
    );
  }

  Future<void> checkCodeForForgotPassword({
    required String verificationId,
    required String smsCode,
    required String phone,
    required BuildContext context,
  }) async {
    _checkCode(
      verificationId: verificationId,
      smsCode: smsCode,
      callback: () {
        state = const AsyncData(null);
        goto(
          context,
          page: ChangePasswordPage(
            phone: phone,
          ),
        );
      },
    );
  }

  Future<bool> _checkCode({
    required String verificationId,
    required String smsCode,
    required Function callback,
  }) async {
    state = const AsyncLoading();
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      final userCredentail =
          await _firebaseAuth.signInWithCredential(credential);
      //state = const AsyncLoading();
      if (userCredentail.user != null) {
        callback();
        return true;
      } else {
        state = const AsyncError("something went wrong!", StackTrace.empty);
        throw const AsyncError("something went wrong!", StackTrace.empty);

      }
    } on FirebaseAuthException catch (e) {
      state =  AsyncError(e.message ?? "something went wrong!", StackTrace.empty);
          throw AsyncError(e.message ?? "something went wrong!", StackTrace.empty);
    } on FirebaseException catch (e) {
      state =  AsyncError(e.message ?? "something went wrong!", StackTrace.empty);
         throw AsyncError(e.message ?? "something went wrong!", StackTrace.empty);
    } catch (e) {
      state = const AsyncError("something went wrong!", StackTrace.empty);
      throw const AsyncError("something went wrong!", StackTrace.empty);
    }
  }



  Future<bool> register({
    required RegisterationForm rf,
  }) async {
    state = const AsyncLoading();
    final result = await _authRepository.register(
      phone: rf.phone,
      password: rf.password,
      name: rf.name,
      referral: rf.referral,
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

  Future<OtpResponse?> verifyOtp({
    required String phone,
    required String code,
  }) async {
    state = const AsyncLoading();
    final result = await _authRepository.verifyOtp(
      phone: phone,
      code: code,
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

  Future<bool> forgotPassword({
    required String phone,
    required String password,
  }) async {
    state = const AsyncLoading();
    final result = await _authRepository.forgotPassword(
      phone: phone,
      password: password,
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
