import 'dart:io';

import 'package:dio/dio.dart';

import '../../../core/global_variables.dart';
import '../../../utils/url_constants.dart';
import '../models/profile_response.dart';

class ProfileService {
  ProfileService(this._dio);

  final Dio _dio;

  Future<ProfileData> getProfile(String token) async {
    try {
      final resp = await _dio.get(
        UrlConst.profileUrl,
        options: Options(
          headers: authHeader(token),
        ),
      );
      final result = ProfileResponse.fromJson(resp.data);
      final ProfileData pd = result.data!;
      final gbalance = await getGameBalance(token, pd.id);
      final profile = pd.copyWith(gameBalance: gbalance.toString());
      return profile;
    } on DioError {
      rethrow;
    }
  }

  Future<double> getGameBalance(String token, userId) async {
    try {
      final resp = await _dio.get(
        UrlConst.gameBalanceUrl(userId),
        options: Options(
          headers: authHeader(token),
        ),
      );
      final balance = double.parse((resp.data?["balance"] ?? 0).toString());
      return balance;
    } on DioError {
      rethrow;
    }
  }

  Future<bool> updateProfile({
    required String token,
    required String name,
    File? image,
    String? email,
    String? birthday,
    String? referral,
  }) async {
    try {
      String fileName = image?.path.split('/').last ?? "";
      FormData formData = FormData.fromMap({
        "name": name,
        "image": image != null
            ? await MultipartFile.fromFile(image.path, filename: fileName)
            : "",
        "email": email,
        "birthday": birthday,
        "referral_id": referral,
      });
      final resp = await _dio.post(
        UrlConst.updateProfileUrl,
        data: formData,
        options: Options(
          headers: authHeader(token),
        ),
      );
      final msg = resp.data?["message"];
      final isSuccess = msg == "success";
      return isSuccess;
    } on DioError {
      rethrow;
    }
  }

  Future<bool> uploadLevel2Image({
    File? image,
    required String token,
  }) async {
    try {
      String fileName = image?.path.split('/').last ?? "";

      FormData formDataT = FormData.fromMap({
        "image": await MultipartFile.fromFile(image!.path, filename: fileName)

      });

      print("file.path ${image?.path}");
      print("testing ${formDataT}");
      final resp = await _dio.post(
        UrlConst.uploadLevelTwoPhotoUrl,
        data: formDataT,
        options: Options(
          headers: authHeader(token),
        ),
      );
      print("testing $resp");
      return resp.statusCode == 200 ? true : false;
    } on DioError {
      rethrow;
    }
  }
}
