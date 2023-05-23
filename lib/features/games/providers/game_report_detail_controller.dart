import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/game_report_detail.dart';
import '../models/game_report_detail_param.dart';
import '../repositories/games_repository.dart';


class GameReportDetailNotifier
    extends StateNotifier<AsyncValue<List<GameReportDetail>>> {
  GameReportDetailNotifier(
    this.gameRepository,
    this.param,
  ) : super(const AsyncLoading()) {
    getGameReportDetail();
  }
  final GameRepository gameRepository;
  final GameReportDetailParam param;
  Future<void> getGameReportDetail() async {
    final result = await gameRepository.getGameReportDetail(param);
    state = result.fold(
      (l) => AsyncError(l.message, StackTrace.empty),
      (r) => AsyncData(r),
    );
  }
}
