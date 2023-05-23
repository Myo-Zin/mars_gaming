import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../../core/global_variables.dart';
import '../../../utils/url_constants.dart';
import '../models/otp_response.dart';

class AuthService {
  final Dio dio;

  AuthService(this.dio);

  Future<String> login({
    required int phone,
    required String password,
  }) async {
    try {
      final resp = await dio.post(
        UrlConst.loginUrl,
        data: {
          "phone": phone,
          "password": password,
        },
      );
      final token = resp.data?["token"];
      String? fcmToken = await FirebaseMessaging.instance.getToken();
      if (fcmToken != null) sendFcmToken(bearToken: token, fcmToken: fcmToken);
      return token;
    } on DioError {
      rethrow;
    }
  }

  Future<bool> optSend({
    required String phone,
  }) async {
    print(phone);
    try {
      final resp = await dio.post(
        UrlConst.otpSend(phone),
      );
      final msg = resp.data?["message"];
      print("$msg");
      final isSuccess = msg == true;
      return isSuccess;
    } on DioError {
      rethrow;
    }
  }

  Future<String> checkPhone({
    required String phone,
  }) async {
    print("testing phone $phone");
    try {
      final resp = await dio.post(
        UrlConst.checkPhone,
        data: {
          "phone": phone
        }
      );
      print("testing ${resp.statusMessage}");
      final msg = resp.data["success"];
      return msg;
    } on DioError {
      rethrow;
    }
  }

  Future<OtpResponse> verifyOtp({
    required String phone,
    required String code,
  }) async {
    print("testing phone $phone");
    try {
      final resp = await dio.post(
        UrlConst.verifyOtp(phone,code),
      );
      print("testing ${resp.statusMessage}");
      Map valueMap = jsonDecode(resp.data);
      print("${valueMap}");
      final list = valueMap.entries.toList();
      OtpResponse otpResponse = OtpResponse( list[1].value, list[3].value);

      return otpResponse;
    } on DioError {
      rethrow;
    }
  }


  Future<void> sendFcmToken({
    required String bearToken,
    required String fcmToken,
  }) async {
    try {
      final result =  await dio.post(
       UrlConst.deviceTokenUrl,
        options: Options(headers: authHeader(bearToken)),
        data: {
          "token": fcmToken,
        },
      );
      print("fcm reslut$result");
    } on DioError {
      rethrow;
    }
  }

  Future<String> register({
    required String name,
    required String phone,
    required String password,
    String? referral,
  }) async {
    try {
      final resp = await dio.post(
        UrlConst.registerUrl,
        data: {
          "phone": phone,
          "password": password,
          "name": name,
          if (referral != null) "referral": referral,
        },
      );
      final token = resp.data?["token"];
      return token;
    } on DioError {
      rethrow;
    }
  }

  Future<bool> forgotPassword({
    required String phone,
    required String password,
  }) async {
    try {
      final resp = await dio.post(
        UrlConst.forgotPasswordUrl,
        data: {
          "phone": phone,
          "password": password,
        },
      );
      final msg = resp.data?["message"];
      final isSuccess = msg == "success";
      return isSuccess;
    } on DioError {
      rethrow;
    }
  }
}
