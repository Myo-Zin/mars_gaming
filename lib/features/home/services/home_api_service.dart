import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
// import 'package:myvip/features/home/models/app_update_response.dart';
// import 'package:myvip/features/home/models/banner_reponse.dart';
// import 'package:myvip/features/home/models/play_text_response.dart';
import '../../../core/global_variables.dart';
import '../../../utils/url_constants.dart';
import '../models/app_update_response.dart';
import '../models/banner_reponse.dart';
import '../models/play_text_response.dart';
import '../models/social_link_response.dart';

class HomeApiService {
  HomeApiService(this._dio);
  final Dio _dio;

  Future<List<BannerProduct>> getBanner() async {
    try {
      final resp = await _dio.get(UrlConst.bannerUrl);
      final bannerResp = BannerResponse.fromJson(resp.data);
      return bannerResp.banner ?? [];
    } on DioError {
      rethrow;
    }
  }

  Future<List<PlayText>> getPlayText() async {
    try {
      final resp = await _dio.get(UrlConst.headerPlayTextUrl);
      final playTextResp = PlayTextResponse.fromJson(resp.data);
      return playTextResp.data ?? [];
    } on DioError {
      rethrow;
    }
  }

  Future<SocialLinks> getSocialLinks() async {
    try {
      final resp = await _dio.get(UrlConst.socialLinkUrl);
      final links = SocialLinks.fromJson(resp.data);
      return links;
    } on DioError {
      rethrow;
    }
  }

  static Future<AppUpdateData?> checkAppUpdate() async {
    try {
      final Dio dio = Dio(BaseOptions(
        headers: authHeader(null),
      ));
      final resp = await dio.get(UrlConst.appUpdateUrl);
      final data = AppUpdateResponse.fromJson(resp.data);
      return data.data;
    } on DioError catch (e) {
      debugPrint("check update error ${e.response?.data}");
      return null;
    }
  }
}
