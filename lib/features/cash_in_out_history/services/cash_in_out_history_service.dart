import 'package:dio/dio.dart';

import '../../../core/global_variables.dart';
import '../models/cash_in_history_response.dart';
import '../models/cash_out_history_response.dart';


class CashInOutHistoryService {
  CashInOutHistoryService(this.dio);
  final Dio dio;

  Future<List<CashInHistory>> getCashInHistory({
    required String token,
    required String url,
  }) async {
    try {
      final resp = await dio.get(
        url,
        options: Options(headers: authHeader(token)),
      );
      final parsedData = CashInHistoryResponse.fromJson(resp.data);
      return parsedData.cashInHistories ?? [];
    } on DioError {
      rethrow;
    }
  }

  Future<List<CashOutHistory>> getCashOutHistory({
    required String token,
    required String url,
  }) async {
    try {
      final resp = await dio.get(
        url,
        options: Options(headers: authHeader(token)),
      );
      final parsedData = CashOutHistoryResponse.fromJson(resp.data);
      return parsedData.cashOutHistories ?? [];
    } on DioError {
      rethrow;
    }
  }
}
