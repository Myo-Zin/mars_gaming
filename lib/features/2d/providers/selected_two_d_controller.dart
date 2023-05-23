import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/two_d.dart';


class SelectedTwoDNotifier extends StateNotifier<List<TwoD>> {
  final List<TwoD> list;

  SelectedTwoDNotifier(this.list) : super(list);

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

  TwoD _checkAndEditAmount(TwoD twoD, double amount) {
    final minAmount = twoD.defaultAmount ?? 0;
    final hotAmount = twoD.hotAmount ?? 0.0;
    final totalAmount = twoD.totalAmount ?? 0.0;
    final overAllAmount = twoD.overallAmount ?? 0.0;
    //this num has hot amount
    if (hotAmount > 0) {
      final left = hotAmount - totalAmount;
      // remaining bet amount is less than min bet amount
      if (left < minAmount) {
        return twoD.copyWith(isGetExpectedAmount: false, betAmount: 0);
      }
      if (amount > left) {
        return twoD.copyWith(betAmount: left, isGetExpectedAmount: false);
      } else {
        return twoD.copyWith(betAmount: amount, isGetExpectedAmount: true);
      }
    } else {
      final left = overAllAmount - totalAmount;
      // remaining bet amount is less than min bet amount
      if (left < minAmount) {
        return twoD.copyWith(isGetExpectedAmount: false, betAmount: 0);
      }
      if (amount > left) {
        return twoD.copyWith(betAmount: left, isGetExpectedAmount: false);
      } else {
        return twoD.copyWith(betAmount: amount, isGetExpectedAmount: true);
      }
    }
  }

  void addAmount(double amount) {
    state = state.map((e) {
      return _checkAndEditAmount(e, amount);
    }).toList();
  }
}
