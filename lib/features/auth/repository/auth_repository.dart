import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../utils/dio_exception.dart';
import '../../../utils/failure.dart';
import '../models/otp_response.dart';
import '../service/auth_service.dart';

class AuthRepository {
  final AuthService _authService;

  AuthRepository(this._authService);

  Future<Either<Failure, String>> login({
    required int phone,
    required String password,
  }) async {
    try {
      final result = await _authService.login(
        phone: phone,
        password: password,
      );

      return right(result);
    } on DioError catch (e) {
      return left(DioException.fromDioError(e).failure);
    }
  }

  Future<Either<Failure, bool>> optSend({
    required String phone,
  }) async {
    try {
      final result = await _authService.optSend(
        phone: phone,
      );
      return right(result);
    } on DioError catch (e) {
      return left(DioException.fromDioError(e).failure);
    }
  }

  Future<Either<Failure, String>> checkPhone({
    required String phone,
  }) async {
    try {
      final result = await _authService.checkPhone(
        phone: phone,
      );
      return right(result);
    } on DioError catch (e) {
      return left(DioException.fromDioError(e).failure);
    }
  }

  Future<Either<Failure, OtpResponse>> verifyOtp({
    required String phone,
    required String code,
  }) async {
    print("testing testing");
    try {
      final result = await _authService.verifyOtp(
        phone: phone,
        code: code,
      );
      return right(result);
    } on DioError catch (e) {
      return left(DioException.fromDioError(e).failure);
    }
  }

  Future<Either<Failure, String>> register({
    required String name,
    required String phone,
    required String password,
    String? referral,
  }) async {
    try {
      final result = await _authService.register(
        phone: phone,
        password: password,
        name: name,
        referral: referral,
      );
      return right(result);
    } on DioError catch (e) {
      return left(DioException.fromDioError(e).failure);
    }
  }



  Future<Either<Failure, bool>> forgotPassword({
    required String phone,
    required String password,
  }) async {
    try {
      final result = await _authService.forgotPassword(
        phone: phone,
        password: password,
      );
      return right(result);
    } on DioError catch (e) {
      return left(DioException.fromDioError(e).failure);
    }
  }
}
