

import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/three_d_lucky_number_history.dart';

part 'three_d_lucky_number_state.freezed.dart';

@freezed
class ThreeDLuckyNumHistoryState with _$ThreeDLuckyNumHistoryState {
  const factory ThreeDLuckyNumHistoryState.empty() = _Empty;
  const factory ThreeDLuckyNumHistoryState.loading() = _Loading;
  const factory ThreeDLuckyNumHistoryState.data(
      List<ThreeDLuckyNumberHistory> threeDLuckyNumHistory) = _Data;
  const factory ThreeDLuckyNumHistoryState.error(String message) = _Error;
}