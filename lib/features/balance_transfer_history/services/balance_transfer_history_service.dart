import 'package:dio/dio.dart';

import '../../../core/global_variables.dart';
import '../models/balance_transfer_history_response.dart';

class BalanceTransferHistoryService {
  BalanceTransferHistoryService(this.dio);
  final Dio dio;

  Future<List<BalanceTransferHistory>> getBalanceTransferHistory({
    required String token,
    required String url,
  }) async {
    try {
      final resp = await dio.get(
        url,
        options: Options(headers: authHeader(token)),
      );
      final parsedData = BalanceTransferHistoryResponse.fromJson(resp.data);
      return parsedData.balanceTransferHistories ?? [];
    } on DioError {
      rethrow;
    }
  }
}
