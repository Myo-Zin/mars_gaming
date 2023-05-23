import 'package:dio/dio.dart';
import '../../../core/global_variables.dart';
import '../../../core/providers/date_state.dart';
import '../../../utils/url_constants.dart';
import '../models/referral_history_response.dart';


class ReferralService {
  ReferralService(this._dio);

  final Dio _dio;

  Future<List<ReferralHistoryData>> getReferralHistory(DateState ds) async {
    try {
      final resp = await _dio.get(
        UrlConst.referralHistoryUrl(
          startDate: ds.startDate!,
          endDate: ds.endDate!,
          type: ds.type!,
        ),
        options: Options(
          headers: authHeader(ds.token),
        ),
      );

      final parsedData = ReferralHistoryResponse.fromJson(resp.data);
      return parsedData.data ?? [];
    } on DioError {
      rethrow;
    }
  }
  Future<bool>claimReferAmount(String token) async {
    try {
      final resp = await _dio.get(
        UrlConst.claimReferralAmountUrl,
        options: Options(
          headers: authHeader(token),
        ),
      );
      return resp.statusCode ==200? true: false ;
    } on DioError {
      rethrow;
    }
  }

}
