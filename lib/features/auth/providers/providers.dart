import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/dio_provider.dart';
import '../models/auth_state.dart';
import '../repository/auth_repository.dart';
import '../service/auth_service.dart';
import 'auth_controller.dart';
import 'check_phone_controller.dart';
import 'login_controller.dart';
import 'opt_send_controller.dart';
import 'register_controller.dart';

final authControllerProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) => AuthNotifier());

final authServiceProvider =
    Provider((ref) => AuthService(ref.read(dioProvider)));
final firebaseAuthProvider = Provider((ref) => FirebaseAuth.instanceFor(app: Firebase.app('default')));

final authRepositoryProvider =
    Provider((ref) => AuthRepository(ref.read(authServiceProvider)));

final loginScreenController =
    StateNotifierProvider<LoginScreenController, AsyncValue<void>>(
  (ref) => LoginScreenController(ref, ref.read(authRepositoryProvider)),
);

final otpSendController =
    StateNotifierProvider.family<OTPSendNotifier, AsyncValue<void>, String>(
  (ref, phone) => OTPSendNotifier(ref, ref.read(authRepositoryProvider), phone),
);
final checkPhoneController =
StateNotifierProvider<CheckPhoneNotifier, AsyncValue<void>>(
        (ref) => CheckPhoneNotifier(ref, ref.read(authRepositoryProvider)),
);

final registerScreenController =
    StateNotifierProvider<RegisterScreenController, AsyncValue<void>>(
  (ref) => RegisterScreenController(
    ref,
    ref.read(authRepositoryProvider),
      ref.read(firebaseAuthProvider),
  ),
);
