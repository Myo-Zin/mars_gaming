import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../core/global_variables.dart';
import '../../../utils/url_constants.dart';
import '../model/cash_in_form.dart';
import '../model/cash_out_form.dart';
import '../model/payment_methods.dart';



class PaymentService {
  final Dio _dio;

  PaymentService(this._dio);

  Future<PaymentMethods> getPaymentMethods(String url) async {
    try {
      final resp = await _dio.get(url);
      final paymentMethods = PaymentMethods.fromJson(resp.data);
      return paymentMethods;
    } on DioError {
      rethrow;
    }
  }

  Future<String> cashIn(CashInForm cashInForm, String token) async {
    print("test out ${cashInForm.userphone}");
    try {
      final resp = await _dio.post(UrlConst.cashInUrl,
          data: {
            "user_id": cashInForm.userid,
            "payment_id": cashInForm.paymentid,
            "account_name": cashInForm.accountname,
            "transaction_id": cashInForm.transactionid,
            "amount": cashInForm.amount,
            "holder_phone": cashInForm.holderPhone,
            "user_phone": cashInForm.userphone,
            "promo_id": cashInForm.promoid,
          },
          options: Options(headers: authHeader(token)));
      final result = resp.data;
      log(result.toString());

      return result.toString();
    } on DioError {
      rethrow;
    }
  }
  Future<String> mobileToUp(CashInForm cashInForm, String token) async {

    try {
      final resp = await _dio.post(UrlConst.cashInUrl,
          data: {
            "user_id": cashInForm.userid,
            "payment_id": cashInForm.paymentid,
            "voucher_code": cashInForm.transactionid,
            "amount": cashInForm.amount,
            "promo_id": cashInForm.promoid,
            "is_mobile_topup": true
          },
          options: Options(headers: authHeader(token)));
      final result = resp.data;
      log(result.toString());

      return result.toString();
    } on DioError {
      rethrow;
    }
  }

  Future<String> cashOut(CashOutForm cashOutForm, String token,String password) async {
    print("test out ${cashOutForm.userphone}");
    try {
      final resp = await _dio.post(UrlConst.cashOutUrl,
          data: {
            "user_id": cashOutForm.userid,
            "payment_id": cashOutForm.paymentid,
            "account_name": cashOutForm.accountname,
            "amount": cashOutForm.amount,
            "user_phone": cashOutForm.userphone,
            "password": password,
          },
          options: Options(
            headers: authHeader(token),
          ));
      final result = resp.data;
      log(result.toString());

      return result.toString();
    } on DioError {
      rethrow;
    }
  }
}
