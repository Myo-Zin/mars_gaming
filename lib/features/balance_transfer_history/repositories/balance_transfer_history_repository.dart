import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../utils/dio_exception.dart';
import '../../../utils/failure.dart';
import '../models/balance_transfer_history_response.dart';
import '../services/balance_transfer_history_service.dart';

class BalanceTransferHistoryRepository {
  final BalanceTransferHistoryService service;

  BalanceTransferHistoryRepository(this.service);

  Future<Either<Failure, List<BalanceTransferHistory>>>
      getBalanceTransferHistory({
    required String token,
    required String url,
  }) async {
    try {
      final result = await service.getBalanceTransferHistory(
        token: token,
        url: url,
      );
      return right(result);
    } on DioError catch (e) {
      return left(DioException.fromDioError(e).failure);
    }
  }
}
