

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/crypto_two_d.dart';

class SelectedCryptoTwoDNotifier extends StateNotifier<List<CryptoTwoD>> {
  final List<CryptoTwoD> list;

  SelectedCryptoTwoDNotifier(this.list) : super(list);

  void delete(int id) {
    state = [
      for (final td in state)
        if (td.id != id) td
    ];
  }

  void editAmount(int id, double amount) {
    state = [
      for (final td in state)
        if (td.id == id) _checkAndEditAmount(td, amount) else td
    ];
  }


  CryptoTwoD _checkAndEditAmount(CryptoTwoD cryptoTwoD, double amount) {
    final minAmount = cryptoTwoD.defaultAmount ?? 0;
    final hotAmount = cryptoTwoD.hotAmount ?? 0.0;
    final totalAmount = cryptoTwoD.totalAmount ?? 0.0;
    final overAllAmount = cryptoTwoD.overallAmount ?? 0.0;
    //this num has hot amount
    if (hotAmount > 0) {
      final left = hotAmount - totalAmount;
      // remaining bet amount is less than min bet amount
      if (left < minAmount) {
        return cryptoTwoD.copyWith(isGetExpectedAmount: false, betAmount: 0);
      }
      if (amount > left) {
        return cryptoTwoD.copyWith(betAmount: left, isGetExpectedAmount: false);
      } else {
        return cryptoTwoD.copyWith(betAmount: amount, isGetExpectedAmount: true);
      }
    } else {
      final left = overAllAmount - totalAmount;
      // remaining bet amount is less than min bet amount
      if (left < minAmount) {
        return cryptoTwoD.copyWith(isGetExpectedAmount: false, betAmount: 0);
      }
      if (amount > left) {
        return cryptoTwoD.copyWith(betAmount: left, isGetExpectedAmount: false);
      } else {
        return cryptoTwoD.copyWith(betAmount: amount, isGetExpectedAmount: true);
      }
    }
  }

  void addAmount(double amount) {
    state = state.map((e) {
      return _checkAndEditAmount(e, amount);
    }).toList();
  }
}
