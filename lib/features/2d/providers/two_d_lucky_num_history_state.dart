

import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/two_d_lucky_num_history.dart';

part 'two_d_lucky_num_history_state.freezed.dart';

@freezed
class TwoDLuckyNumHistoryState with _$TwoDLuckyNumHistoryState {
  const factory TwoDLuckyNumHistoryState.empty() = _Empty;
  const factory TwoDLuckyNumHistoryState.loading() = _Loading;
  const factory TwoDLuckyNumHistoryState.data(
      List<TwoDLuckyNumHistory> threeDLuckyNumHistory) = _Data;
  const factory TwoDLuckyNumHistoryState.error(String message) = _Error;
}