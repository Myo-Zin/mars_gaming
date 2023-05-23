import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../core/providers/date_state.dart';
import '../../../utils/dio_exception.dart';
import '../../../utils/failure.dart';
import '../models/Three_d_lucky_number.dart';
import '../models/three_d.dart';
import '../models/three_d_bet_slip.dart';
import '../models/three_d_lucky_number_history.dart';
import '../models/three_d_section.dart';
import '../services/three_d_service.dart';

class ThreeDRepository {
  ThreeDRepository(this.service);
  final ThreeDService service;

  Future<Either<Failure, List<ThreeD>>> getThreeDList() async {
    try {
      final result = await service.getThreeDList();
      return right(result);
    } on DioError catch (e) {
      return left(DioException.fromDioError(e).failure);
    }
  }

  Future<Either<Failure, ThreeDSection>> getThreeDSection() async {
    try {
      final result = await service.getThreeDSection();
      log(result.toString());
      return right(result);
    } on DioError catch (e) {
      return left(DioException.fromDioError(e).failure);
    }
  }

  Future<Either<Failure, Unit>> betThreeD({
    required List<ThreeD> threeDList,
    required ThreeDSection section,
    required String token,
  }) async {
    try {
      await service.betThreeD(
        threeDList: threeDList,
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

  Future<Either<Failure, List<ThreeDLuckyNumber>>>
      getThreeDLuckyNumberList() async {
    try {
      final result = await service.getThreeDLuckyNumberList();

      return right(result);
    } on DioError catch (e) {
      return left(DioException.fromDioError(e).failure);
    }
  }

  Future<Either<Failure, List<ThreeDBetSlip>>> getThreeDBetSlipHistory(
      DateState ds) async {
    try {
      final result = await service.getThreeDBetSlipHistory(ds);
      return right(result);
    } on DioError catch (e) {
      return left(DioException.fromDioError(e).failure);
    }
  }

  Future<Either<Failure, List<ThreeDLuckyNumberHistory>>> getThreeDLuckyNumHistory(
      DateState ds) async {
    try {
      final result = await service.getThreeDLuckyNumberHistory(ds);
      return right(result);
    } on DioError catch (e) {
      return left(DioException.fromDioError(e).failure);
    }
  }
}
