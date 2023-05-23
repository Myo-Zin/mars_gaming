import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../utils/dio_exception.dart';
import '../../../utils/failure.dart';
import '../model/cash_in_form.dart';
import '../model/cash_out_form.dart';
import '../model/payment_methods.dart';
import '../services/payment_service.dart';


class PaymentRepository {
  final PaymentService _paymentService;

  PaymentRepository(this._paymentService);

  Future<Either<Failure, PaymentMethods>> getPaymentMethods(String url) async {
    try {
      final result = await _paymentService.getPaymentMethods(url);
      return right(result);
    } on DioError catch (e) {
      return left(DioException.fromDioError(e).failure);
    }
  }

  Future<Either<Failure, Unit>> cashIn(
      CashInForm cashInForm, String token) async {
    try {
      final _ = await _paymentService.cashIn(
        cashInForm,
        token,
      );
      return right(unit);
    } on DioError catch (e) {
      return left(DioException.fromDioError(e).failure);
    }
  }

  Future<Either<Failure, Unit>> mobileToUp(
      CashInForm cashInForm, String token) async {
    try {
      final _ = await _paymentService.mobileToUp(
        cashInForm,
        token,
      );
      return right(unit);
    } on DioError catch (e) {
      return left(DioException.fromDioError(e).failure);
    }
  }

  Future<Either<Failure, Unit>> cashOut(
      CashOutForm cashOutForm, String token,String password) async {
    try {
      final _ = await _paymentService.cashOut(
        cashOutForm,
        token,
        password
      );
      return right(unit);
    } on DioError catch (e) {
      return left(DioException.fromDioError(e).failure);
    }
  }
}
