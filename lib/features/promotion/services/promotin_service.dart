import 'package:dio/dio.dart';

import '../../../utils/url_constants.dart';
import '../model/promotin_response.dart';


class PromotionService {
  PromotionService(this.dio);

  final Dio dio;

  Future<List<Promotion>> getPromotion() async {
    try {
      final resp = await dio.get(
        UrlConst.getPromotionCashIn,
        //options: Options(headers: authHeader()),
      );
      final list = PromotionResponse.fromJson(resp.data);
      return list.data ?? [];
    } on DioError {
      rethrow;
    }
  }
}
