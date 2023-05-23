import 'dart:convert';

import 'package:dio/dio.dart';
import '../../../core/global_variables.dart';
import '../../../core/providers/date_state.dart';
import '../../../utils/failure.dart';
import '../../../utils/url_constants.dart';
import '../models/Three_d_lucky_number.dart';
import '../models/three_d.dart';
import '../models/three_d_bet_slip.dart';
import '../models/three_d_bet_slip_history_response.dart';
import '../models/three_d_lucky_number_history.dart';
import '../models/three_d_response.dart';
import '../models/three_d_section.dart';

class ThreeDService {
  ThreeDService(this.dio);
  final Dio dio;

  Future<ThreeDSection> getThreeDSection() async {
    try {
      final resp = await dio.get(
        UrlConst.threeDSectionUrl,
      );
      final section = ThreeDSection.fromJson(resp.data);
      return section;
    } on DioError {
      rethrow;
    }
  }

  Future<List<ThreeD>> getThreeDList() async {
    try {
      final resp = await dio.get(
        UrlConst.threeDUrl,
      );
      final list = ThreeDResponse.fromJson(resp.data);
      return list.data?.map((e) => e.copyWith()).toList() ?? [];
    } on DioError {
      rethrow;
    }
  }

  Future<dynamic> betThreeD({
    required List<ThreeD> threeDList,
    required ThreeDSection section,
    required String token,
  }) async {
    try {
      final list = threeDList.where((e) => e.betAmount! > 0).toList();
      if (list.isEmpty) {
        throw Failure("ရွေးချယ်ထားသောဂဏန်းများမှာ ထိုး၍ မရတော့ပါ။");
      }
      Map<String, dynamic> map = {
        "category_id": 2,
        "section": section.section,
        "date_3d": section.date3d,
        "bet_obj": [
          for (final td in list)
            td.toBetObject(
              section.section!,
              section.date3d!,
            )
        ]
      };
      final resp = await dio.post(
        UrlConst.threeDBetUrl,
        options: Options(headers: authHeader(token)),
        data: jsonEncode(map),
      );
      return resp.data;
    } on DioError {
      rethrow;
    }
  }

  Future<List<ThreeDLuckyNumber>> getThreeDLuckyNumberList() async {
    try {
      final resp = await dio.get(UrlConst.threeDLuckyNumberUrl);
      final List<dynamic>? list = resp.data;
      final numlist = list?.map((e) => ThreeDLuckyNumber.fromJson(e)).toList();
      return numlist ?? [];
    } on DioError {
      rethrow;
    }
  }

  Future<List<ThreeDBetSlip>> getThreeDBetSlipHistory(DateState ds) async {
    try {
      final resp = await dio.get(
        UrlConst.threeDBetSlipUrl(
          startDate: ds.startDate!,
          endDate: ds.endDate!,
        ),
        options: Options(
          headers: authHeader(ds.token),
        ),
      );

      final list = ThreeDBetSlipResponse.fromJson(resp.data);
      return list.data ?? [];
    } on DioError {
      rethrow;
    }
  }
  Future<List<ThreeDLuckyNumberHistory>> getThreeDLuckyNumberHistory(DateState ds) async {
    try {
      final resp = await dio.get(
        UrlConst.threeDLuckyNumHistoryUrl(
          startDate: ds.startDate!,
          endDate: ds.endDate!,
        ),
        options: Options(
          headers: authHeader(ds.token),
        ),
      );
      final list = ThreeDLuckyNumberHistoryResponse.fromJson(resp.data);
      print("$list");
      return list.data??[];
    } on DioError {
      rethrow;
    }
  }
}
