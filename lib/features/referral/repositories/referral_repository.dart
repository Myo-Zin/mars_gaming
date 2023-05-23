import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../core/providers/date_state.dart';
import '../../../utils/dio_exception.dart';
import '../../../utils/failure.dart';
import '../models/referral_history_response.dart';
import '../service/referral_service.dart';

class ReferralHistoryRepository {
  ReferralHistoryRepository(this.service);
  final ReferralService service;

  Future<Either<Failure, List<ReferralHistoryData>>> getReferralHistoryList(DateState ds) async {
    try {
      final result = await service.getReferralHistory(ds);
      return right(result);
    } on DioError catch (e) {
      return left(DioException.fromDioError(e).failure);
    }
  }

  Future<Either<Failure,bool>>claimReferAmount(String token) async {
    try {
      final result = await service.claimReferAmount(token);
      return right(result);
    } on DioError catch (e) {
      return left(DioException.fromDioError(e).failure);
    }
  }
}