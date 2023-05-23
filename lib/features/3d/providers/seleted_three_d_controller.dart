import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/three_d.dart';

class SelectedThreeDNotifier extends StateNotifier<List<ThreeD>> {
  final List<ThreeD> list;

  SelectedThreeDNotifier(this.list) : super(list);

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

  ThreeD _checkAndEditAmount(ThreeD threeD, double amount) {
    final minAmount = threeD.defaultAmount ?? 0;
    final hotAmount = double.parse(threeD.hotAmount.toString());
    final totalAmount = threeD.totalAmount ?? 0.0;
    final overAllAmount = threeD.overallAmount ?? 0.0;
    //this num has hot amount
    if (hotAmount > 0) {
      final left = hotAmount - totalAmount;
      // remaining bet amount is less than min bet amount
      if (left < minAmount) {
        return threeD.copyWith(isGetExpectedAmount: false, betAmount: 0);
      }
      if (amount > left) {
        return threeD.copyWith(betAmount: left, isGetExpectedAmount: false);
      } else {
        return threeD.copyWith(betAmount: amount, isGetExpectedAmount: true);
      }
    } else {
      final left = overAllAmount - totalAmount;
      // remaining bet amount is less than min bet amount
      if (left < minAmount) {
        return threeD.copyWith(isGetExpectedAmount: false, betAmount: 0);
      }
      if (amount > left) {
        return threeD.copyWith(betAmount: left, isGetExpectedAmount: false);
      } else {
        return threeD.copyWith(betAmount: amount, isGetExpectedAmount: true);
      }
    }
  }

  void addAmount(double amount) {
    state = state.map((e) {
      return _checkAndEditAmount(e, amount);
    }).toList();
  }
}
