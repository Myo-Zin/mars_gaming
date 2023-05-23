

import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/game_report_response.dart';

part 'game_report_state.freezed.dart';

@freezed
class GameReportState with _$GameReportState {
  const factory GameReportState.empty() = _Empty;
  const factory GameReportState.loading() = _Loading;
  const factory GameReportState.data(List<GameReport> reports) = _Data;
  const factory GameReportState.error(String message) = _Error;
}
