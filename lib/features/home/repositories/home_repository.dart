import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../utils/dio_exception.dart';
import '../../../utils/failure.dart';
import '../models/banner_reponse.dart';
import '../models/play_text_response.dart';
import '../models/social_link_response.dart';
import '../services/home_api_service.dart';

class HomeRepository {
  HomeRepository(this.api);

  final HomeApiService api;

  Future<Either<Failure, List<BannerProduct>>> getBanner() async {
    try {
      final banners = await api.getBanner();
      return right(banners);
    } on DioError catch (e) {
      return left(DioException
          .fromDioError(e)
          .failure);
    }
  }

  Future<Either<Failure, List<PlayText>>> getPlayText() async {
    try {
      final texts = await api.getPlayText();
      return right(texts);
    } on DioError catch (e) {
      return left(DioException.fromDioError(e).failure);
    }
  }

  Future<Either<Failure, SocialLinks>> getSocialLinks() async {
    try {
      final links = await api.getSocialLinks();
      return right(links);
    } on DioError catch (e) {
      return left(DioException.fromDioError(e).failure);
    }
  }
}