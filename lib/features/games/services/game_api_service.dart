import 'package:dio/dio.dart';
import '../../../core/global_variables.dart';
import '../../../core/providers/date_state.dart';
import '../../../utils/url_constants.dart';
import '../models/game_category_response.dart';
import '../models/game_report_detail.dart';
import '../models/game_report_detail_param.dart';
import '../models/game_report_response.dart';
import '../models/game_response.dart';
import '../models/hot_new_game_response.dart';

class GameApiService {
  final Dio _dio;
  GameApiService(this._dio);

  Future<List<Game>> getGames(String url) async {
    try {
      final resp = await _dio.get(url);

      final result = GamesResponse.fromJson(resp.data);

      return result.data ?? [];
    } on DioError {
      rethrow;
    }
  }

  Future<List<HotNewGame>> getHotNewGames() async {
    try {
      final resp = await _dio.get(UrlConst.hotNewGamesUrl);

      final result = HotNewGameResponse.fromJson(resp.data);

      return result.data ?? [];
    } on DioError {
      rethrow;
    }
  }

  Future<List<GameCategory>> getGameCategory(String url) async {
    try {
      final resp = await _dio.get(url);

      final result = GameCategoryResponse.fromJson(resp.data);

      return result.data ?? [];
    } on DioError {
      rethrow;
    }
  }

  Future<String> getGameViewUrl({
    required String token,
    required int userId,
    required String gameCode,
  }) async {
    try {
      final resp = await _dio.get(
        UrlConst.gameViewUrl(userId, gameCode),
        options: Options(
          //headers: authHeader(token),
        ),
      );

      final url = resp.data["res"];

      return url;
    } on DioError {
      rethrow;
    }
  }

  Future<List<GameReport>> getGameReports(DateState ds) async {
    try {
      final resp = await _dio.get(
        UrlConst.gameReports(
          startDate: ds.startDate!,
          endDate: ds.endDate!,
        ),

        options: Options(
           headers: authHeader(ds.token),
        ),
      );

      final list = GameReportResponse.fromJson(resp.data);
      return list.data ?? [];
    } on DioError {
      rethrow;
    }
  }

  Future<List<GameReportDetail>> getGameReportDetail(
      GameReportDetailParam param) async {
    try {
      final resp = await _dio.get(
        UrlConst.gameReportDetail(
          date: param.date,
          provider: param.provider,
          usercode: param.usercode,
        ),
        options: Options(

          headers: authHeader(param.token),
        ),
      );

      final List<dynamic> list = resp.data;
      final reportDetailList =
          list.map((e) => GameReportDetail.fromJson(e)).toList();
      return reportDetailList;
    } on DioError {
      rethrow;
    }
  }
}
