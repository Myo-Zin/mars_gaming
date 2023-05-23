

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../utils/dio_exception.dart';
import '../../../utils/failure.dart';
import '../model/winnner_response.dart';
import '../service/winner_service.dart';

class WinnerRepository {
  WinnerRepository(this.service);

  final WinnerService service;

  Future<Either<Failure, List<Winner>>> getWinnerList(String url) async {
    try {
     final result = await service.getWinnerList(url);
      return right(result);
    } on DioError catch (e) {
      return left(DioException
          .fromDioError(e)
          .failure);
    }
  }
}