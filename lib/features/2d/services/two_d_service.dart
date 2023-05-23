import 'dart:convert';

import 'package:dio/dio.dart';
import '../../../core/global_variables.dart';
import '../../../core/providers/date_state.dart';
import '../../../utils/failure.dart';
import '../../../utils/url_constants.dart';
import '../models/thai_two_d_live.dart';
import '../models/two_d.dart';
import '../models/two_d_bet_slips_history_response.dart';
import '../models/two_d_lucky_num_history.dart';
import '../models/two_d_lucky_number.dart';
import '../models/two_d_response.dart';
import '../models/two_d_section.dart';
import '../models/two_d_section_response.dart';

class TwoDService {
  TwoDService(this.dio);
  final Dio dio;

  Future<List<TwoD>> getTwoDList(String section) async {
    try {
      final resp = await dio.post(
        UrlConst.twodUrl,
        data: {"section": section},
      );
      final list = TwoDResponse.fromJson(resp.data);
      return list.data?.map((e) => e.copyWith(section: section)).toList() ?? [];
    } on DioError {
      rethrow;
    }
  }

  Future<List<BetSlip>> getTwoDBetSlipHistory(DateState ds) async {
    try {
      final resp = await dio.get(
        UrlConst.twoDBetSlipsHistoryUrl(
          startDate: ds.startDate!,
          endDate: ds.endDate!,
        ),
        options: Options(
          headers: authHeader(ds.token),
        ),
      );

      final list = TwoDBetSlipHistoryResponse.fromJson(resp.data);
      return list.data ?? [];
    } on DioError {
      rethrow;
    }
  }

  Future<List<TwoDSection>> getTwoDSection() async {
    try {
      final twoDResp = await dio.post(
        UrlConst.twodUrl,
        data: {"section": "null"},
      );
      final isClose = twoDResp.data["game"] == "close";
      if (isClose) {
        return [];
      }
      final resp = await dio.get(UrlConst.twodSectionUrl);
      final list = TwoDSectionResponse.fromJson(resp.data);
      return list.data ?? [];
    } on DioError {
      rethrow;
    }
  }

  Future<List<TwoDLuckyNumber>> getTwoDLuckyNumberDailyList() async {
    try {
      final resp = await dio.get(UrlConst.twoDluckyNumberDailyList);
      final List<dynamic>? list = resp.data;
      final numlist = list?.map((e) => TwoDLuckyNumber.fromJson(e)).toList();
      return numlist ?? [];
    } on DioError {
      rethrow;
    }
  }

  Future<ThaiTwoDLive> getThaiTwoDLive() async {
    try {
      final resp = await dio.get(UrlConst.thaiTwoDLive);

      final liveData = ThaiTwoDLive.fromJson(resp.data["live"]);
      return liveData;
    } on DioError {
      rethrow;
    }
  }

  Future<dynamic> betTwoD({
    required List<TwoD> twoDList,
    required String section,
    required String token,
  }) async {
    try {
      final list = twoDList.where((e) => e.betAmount! > 0).toList();
      if (list.isEmpty) {
        throw Failure("ရွေးချယ်ထားသောဂဏန်းများမှာ ထိုး၍ မရတော့ပါ။");
      }
      Map<String, dynamic> map = {
        "category_id": 1,
        "section": section,
        "bet_obj": [for (final td in list) td.toBetObject()]
      };

      final resp = await dio.post(
        UrlConst.twoDBettingUrl,
        options: Options(headers: authHeader(token)),
        data: jsonEncode(map),
      );
      return resp.data;
    } on DioError {
      rethrow;
    }
  }

  Future<List<TwoDLuckyNumHistory>> getTowDLuckyNumberHistory(DateState ds) async {
    try {
      final resp = await dio.get(
        UrlConst.twoDLuckyNumHistoryUrl(
          startDate: ds.startDate!,
          endDate: ds.endDate!,
        ),
        options: Options(
          headers: authHeader(ds.token),
        ),
      );
      final list = TwoDLuckyNumHistoryResponse.fromJson(resp.data);
      return list.data??[];
    } on DioError {
      rethrow;
    }
  }
}
