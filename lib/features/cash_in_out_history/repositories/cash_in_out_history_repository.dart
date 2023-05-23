import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';


import '../../../core/providers/date_state.dart';
import '../../../utils/dio_exception.dart';
import '../../../utils/failure.dart';
import '../../../utils/url_constants.dart';
import '../models/cash_in_history_response.dart';
import '../models/cash_out_history_response.dart';
import '../services/cash_in_out_history_service.dart';

class CashInOutHistoryRepository {
  final CashInOutHistoryService service;

  CashInOutHistoryRepository(this.service);

  Future<Either<Failure, List<CashInHistory>>> getCashInHistory(
    DateState dateState,
  ) async {
    print("text${dateState.token}");
    try {
      final result = await service.getCashInHistory(
        token: dateState.token!,
        url: UrlConst.getCashInHistoryUrl(
          userId: dateState.userId!,
          startDate: dateState.startDate!,
          endDate: dateState.endDate!,
        ),
      );

      return right(result);
    } on DioError catch (e) {
      log(e.response?.data??"gg");
      return left(DioException.fromDioError(e).failure);
    }
  }

  Future<Either<Failure, List<CashOutHistory>>> getCashOutHistory(
    DateState dateState,
  ) async {
    try {
      final result = await service.getCashOutHistory(
        token: dateState.token!,
        url: UrlConst.getCashOutHistoryUrl(
          userId: dateState.userId!,
          startDate: dateState.startDate!,
          endDate: dateState.endDate!,
        ),
      );
      return right(result);
    } on DioError catch (e) {
      return left(DioException.fromDioError(e).failure);
    }
  }
}
