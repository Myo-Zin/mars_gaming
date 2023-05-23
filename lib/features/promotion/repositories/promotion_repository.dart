import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../utils/dio_exception.dart';
import '../../../utils/failure.dart';
import '../model/promotin_response.dart';
import '../services/promotin_service.dart';

class PromotionRepository {
  PromotionRepository(this.service);

  final PromotionService service;

  Future<Either<Failure, List<Promotion>>> getPromotion() async {
    try {
      final result = await service.getPromotion();
      return right(result);
    } on DioError catch (e) {
      return left(DioException.fromDioError(e).failure);
    }
  }
}
