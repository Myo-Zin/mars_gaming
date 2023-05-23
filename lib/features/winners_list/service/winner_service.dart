import 'package:dio/dio.dart';

import '../../../utils/url_constants.dart';
import '../model/winnner_response.dart';

class WinnerService {
  WinnerService(this.dio);

  final Dio dio;

  Future<List<Winner>> getWinnerList(String url) async {
    try {
      final resp = await dio.get(
        url
      );
      final result = WinnerResponse.fromJson(resp.data);
      return result.data?? [];
    } on DioError {
      rethrow;
    }
  }
}