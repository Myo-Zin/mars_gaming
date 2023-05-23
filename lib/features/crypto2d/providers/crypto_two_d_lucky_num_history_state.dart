

import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/crypto_two_d_lucky_num_history.dart';

part 'crypto_two_d_lucky_num_history_state.freezed.dart';

@freezed
class CryptoTwoDLuckyNumHistoryState with _$CryptoTwoDLuckyNumHistoryState {
  const factory CryptoTwoDLuckyNumHistoryState.empty() = _Empty;
  const factory CryptoTwoDLuckyNumHistoryState.loading() = _Loading;
  const factory CryptoTwoDLuckyNumHistoryState.data(
      List<CryptoTwoDLuckyNumHistory> threeDLuckyNumHistory) = _Data;
  const factory CryptoTwoDLuckyNumHistoryState.error(String message) = _Error;
}