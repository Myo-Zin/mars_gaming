import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../../../core/global_variables.dart';
import '../../../core/providers/date_state.dart';
import '../../../utils/failure.dart';
import '../../../utils/url_constants.dart';
import '../models/crypto_two_d.dart';
import '../models/crypto_two_d_bet_slips_history_response.dart';
import '../models/crypto_two_d_lucky_num_history.dart';
import '../models/crypto_two_d_lucky_number.dart';
import '../models/crypto_two_d_response.dart';
import '../models/crypto_two_d_section.dart';
import '../models/crypto_two_d_section_response.dart';

class CryptoTwoDService {
  CryptoTwoDService(this.dio);

  final Dio dio;

  Future<List<CryptoTwoD>> getCryptoTwoDList(String section) async {
    try {
      final resp = await dio.post(
        UrlConst.cryptoTwoDUrl,
        data: {"section": section},
      );
      final list = CryptoTwoDResponse.fromJson(resp.data);
      return list.data?.map((e) => e.copyWith(section: section)).toList() ?? [];
    } on DioError {
      rethrow;
    }
  }

  Future<List<BetSlip>> getCryptoTwoDBetSlipHistory(DateState ds) async {
    try {
      final resp = await dio.get(
        UrlConst.cryptoTwoDBetSlipsHistoryUrl(
          startDate: ds.startDate!,
          endDate: ds.endDate!,
        ),
        options: Options(
          headers: authHeader(ds.token),
        ),
      );

      final list = CryptoTwoDBetSlipHistoryResponse.fromJson(resp.data);
      return list.data ?? [];
    } on DioError {
      rethrow;
    }
  }

  Future<List<CryptoTwoDSection>> getCryptoTwoDSection() async {
    try {
      final twoDResp = await dio.post(
        UrlConst.cryptoTwoDUrl,
        data: {"section": "null"},
      );
      final isClose = twoDResp.data["game"] == "close";
      if (isClose) {
        return [];
      }
      final resp = await dio.get(UrlConst.cryptoTwoDSectionUrl);
      final list = CryptoTwoDSectionResponse.fromJson(resp.data);
      return list.data ?? [];
    } on DioError {
      rethrow;
    }
  }

  Future<List<CryptoTwoDLuckyNumber>>
      getCryptoTwoDLuckyNumberDailyList() async {
    try {
      final resp = await dio.get(UrlConst.cryptoTwoDLuckyNumberDailyList);
      final List<dynamic>? list = resp.data;
      final numlist =
          list?.map((e) => CryptoTwoDLuckyNumber.fromJson(e)).toList();
      return numlist ?? [];
    } on DioError {
      rethrow;
    }
  }

  // Future<ThaiTwoDLive> getThaiTwoDLive() async {
  //   try {
  //     final resp = await dio.get(UrlConst.thaiTwoDLive);
  //
  //     final liveData = ThaiTwoDLive.fromJson(resp.data["live"]);
  //     return liveData;
  //   } on DioError {
  //     rethrow;
  //   }
  // }

  Future<dynamic> betCryptoTwoD({
    required List<CryptoTwoD> cryptoTwoDList,
    required String section,
    required String token,
  }) async {
    try {
      final list = cryptoTwoDList.where((e) => e.betAmount! > 0).toList();
      if (list.isEmpty) {
        throw Failure("ရွေးချယ်ထားသောဂဏန်းများမှာ ထိုး၍ မရတော့ပါ။");
      }
      Map<String, dynamic> map = {
        "category_id": 3,
        "section": section,
        "bet_obj": [for (final td in list) td.toBetObject()]
      };

      final resp = await dio.post(
        UrlConst.cryptoTwoDBettingUrl,
        options: Options(headers: authHeader(token)),
        data: jsonEncode(map),
      );
      debugPrint("$resp");
      return resp.data;
    } on DioError {
      rethrow;
    }
  }

Future<List<CryptoTwoDLuckyNumHistory>> getCryptoTowDLuckyNumberHistory(DateState ds) async {
  try {
    final resp = await dio.get(
      UrlConst.cryptoTwoDLuckyNumHistoryUrl(
        startDate: ds.startDate!,
        endDate: ds.endDate!,
      ),
      options: Options(
        headers: authHeader(ds.token),
      ),
    );
    final list = CryptoTwoDLuckyNumHistoryResponse.fromJson(resp.data);
    return list.data??[];
  } on DioError {
    rethrow;
  }
}
}
