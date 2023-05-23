import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../core/providers/date_state.dart';
import '../../../utils/dio_exception.dart';
import '../../../utils/failure.dart';
import '../models/thai_two_d_live.dart';
import '../models/two_d.dart';
import '../models/two_d_bet_slips_history_response.dart';
import '../models/two_d_lucky_num_history.dart';
import '../models/two_d_lucky_number.dart';
import '../models/two_d_section.dart';
import '../services/two_d_service.dart';

class TwoDRepository {
  TwoDRepository(this.service);
  final TwoDService service;

  Future<Either<Failure, List<TwoD>>> getTwoDList(String section) async {
    try {
      final result = await service.getTwoDList(section);
      return right(result);
    } on DioError catch (e) {
      return left(DioException.fromDioError(e).failure);
    }
  }

  Future<Either<Failure, List<BetSlip>>> getTwoDBetSlipHistory(
      DateState ds) async {
    try {
      final result = await service.getTwoDBetSlipHistory(ds);
      return right(result);
    } on DioError catch (e) {
      return left(DioException.fromDioError(e).failure);
    }
  }

  Future<Either<Failure, List<TwoDSection>>> getTwoDSectionList() async {
    try {
      final result = await service.getTwoDSection();
      return right(result);
    } on DioError catch (e) {
      return left(DioException.fromDioError(e).failure);
    }
  }

  Future<Either<Failure, Unit>> betTwoD({
    required List<TwoD> twoDList,
    required String section,
    required String token,
  }) async {
    try {
      await service.betTwoD(
        twoDList: twoDList,
        section: section,
        token: token,
      );
      return right(unit);
    } on DioError catch (e) {
      return left(DioException.fromDioError(e).failure);
    } on Failure catch (e) {
      return left(e);
    }
  }

  Future<Either<Failure, List<TwoDLuckyNumber>>>
      getTwoDLuckyNumberDailyList() async {
    try {
      final result = await service.getTwoDLuckyNumberDailyList();

      return right(result);
    } on DioError catch (e) {
      return left(DioException.fromDioError(e).failure);
    }
  }

  Future<Either<Failure, ThaiTwoDLive>> getThaiTwoDLive() async {
    try {
      final result = await service.getThaiTwoDLive();

      return right(result);
    } on DioError catch (e) {
      return left(DioException.fromDioError(e).failure);
    }
  }

  Future<Either<Failure, List<TwoDLuckyNumHistory>>> getTwoLuckyNumHistory(
      DateState ds) async {
    try {
      final result = await service.getTowDLuckyNumberHistory(ds);
      return right(result);
    } on DioError catch (e) {
      return left(DioException.fromDioError(e).failure);
    }
  }
}
