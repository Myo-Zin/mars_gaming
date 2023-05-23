import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/providers/date_state.dart';
import '../../../utils/dio_exception.dart';
import '../../../utils/failure.dart';
import '../models/game_category_response.dart';
import '../models/game_report_detail.dart';
import '../models/game_report_detail_param.dart';
import '../models/game_report_response.dart';
import '../models/game_response.dart';
import '../models/hot_new_game_response.dart';
import '../services/game_api_service.dart';


class GameRepository {
  final GameApiService _apiService;
  GameRepository(this._apiService);

  Future<Either<Failure, List<Game>>> getGames(String url) async {
    try {
      final result = await _apiService.getGames(url);
      return right(result);
    } on DioError catch (e) {
      return left(DioException.fromDioError(e).failure);
    }
  }

  Future<Either<Failure, List<HotNewGame>>> getHotNewGames() async {
    try {
      final result = await _apiService.getHotNewGames();
      return right(result);
    } on DioError catch (e) {
      return left(DioException.fromDioError(e).failure);
    }
  }

  Future<Either<Failure, List<GameCategory>>> getGameCategory(
      String url) async {
    try {
      final result = await _apiService.getGameCategory(url);
      return right(result);
    } on DioError catch (e) {
      return left(DioException.fromDioError(e).failure);
    }
  }

  Future<Either<Failure, String>> getGameViewUrl({
    required String token,
    required int userId,
    required String gameCode,
  }) async {
    try {
      final url = await _apiService.getGameViewUrl(
        token: token,
        userId: userId,
        gameCode: gameCode,
      );
      return right(url);
    } on DioError catch (e) {
      return left(DioException.fromDioError(e).failure);
    }
  }

  Future<Either<Failure, List<GameReport>>> getGameReports(
      DateState ds) async {
    try {
      final result = await _apiService.getGameReports(ds);
      return right(result);
    } on DioError catch (e) {
      return left(DioException.fromDioError(e).failure);
    }
  }

  Future<Either<Failure, List<GameReportDetail>>> getGameReportDetail(
      GameReportDetailParam param) async {
    try {
      final result = await _apiService.getGameReportDetail(param);
      return right(result);
    } on DioError catch (e) {
      return left(DioException.fromDioError(e).failure);
    }
  }
}
