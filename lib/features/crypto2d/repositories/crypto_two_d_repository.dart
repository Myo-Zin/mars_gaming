import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../core/providers/date_state.dart';
import '../../../utils/dio_exception.dart';
import '../../../utils/failure.dart';
import '../models/crypto_two_d.dart';
import '../models/crypto_two_d_bet_slips_history_response.dart';
import '../models/crypto_two_d_lucky_num_history.dart';
import '../models/crypto_two_d_lucky_number.dart';
import '../models/crypto_two_d_section.dart';
import '../services/crypto_two_d_service.dart';

class CryptoTwoDRepository {
  CryptoTwoDRepository(this.service);
  final CryptoTwoDService service;

  Future<Either<Failure, List<CryptoTwoD>>> getCryptoTwoDList(String section) async {
    try {
      final result = await service.getCryptoTwoDList(section);
      return right(result);
    } on DioError catch (e) {
      return left(DioException.fromDioError(e).failure);
    }
  }

  Future<Either<Failure, List<BetSlip>>> getCryptoTwoDBetSlipHistory(
      DateState ds) async {
    try {
      final result = await service.getCryptoTwoDBetSlipHistory(ds);
      return right(result);
    } on DioError catch (e) {
      return left(DioException.fromDioError(e).failure);
    }
  }

  Future<Either<Failure, List<CryptoTwoDSection>>> getCryptoTwoDSectionList() async {
    try {
      final result = await service.getCryptoTwoDSection();
      return right(result);
    } on DioError catch (e) {
      return left(DioException.fromDioError(e).failure);
    }
  }

  Future<Either<Failure, Unit>> betCryptoTwoD({
    required List<CryptoTwoD> cryptoTwoDList,
    required String section,
    required String token,
  }) async {
    try {
      await service.betCryptoTwoD(
        cryptoTwoDList: cryptoTwoDList,
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

  Future<Either<Failure, List<CryptoTwoDLuckyNumber>>>
      getCryptoTwoDLuckyNumberDailyList() async {
    try {
      final result = await service.getCryptoTwoDLuckyNumberDailyList();

      return right(result);
    } on DioError catch (e) {
      return left(DioException.fromDioError(e).failure);
    }
  }

  // Future<Either<Failture, ThaiTwoDLive>> getThaiTwoDLive() async {
  //   try {
  //     final result = await service.getThaiTwoDLive();
  //
  //     return right(result);
  //   } on DioError catch (e) {
  //     return left(DioException.fromDioError(e).failture);
  //   }
  // }
  //
  Future<Either<Failure, List<CryptoTwoDLuckyNumHistory>>> getCryptoTowDLuckyNumberHistory(
      DateState ds) async {
    try {
      final result = await service.getCryptoTowDLuckyNumberHistory(ds);
      return right(result);
    } on DioError catch (e) {
      return left(DioException.fromDioError(e).failure);
    }
  }
}
