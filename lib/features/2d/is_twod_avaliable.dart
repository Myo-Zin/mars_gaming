  import 'models/two_d.dart';

bool isTwoDAvalible(TwoD twoD) {
    if (twoD.block == true) {
      return false;
    }
    final minAmount = twoD.defaultAmount ?? 0;
    final hotAmount = twoD.hotAmount ?? 0.0;
    final totalAmount = twoD.totalAmount ?? 0.0;
    final overAllAmount = twoD.overallAmount ?? 0.0;
    //this num has hot amount
    if (hotAmount > 0) {
      final left = hotAmount - totalAmount;
      // remaining bet amount is less than min bet amount
      if (left < minAmount) {
        return false;
      } else {
        return true;
      }
    } else {
      final left = overAllAmount - totalAmount;
      // remaining bet amount is less than min bet amount
      if (left < minAmount) {
        return false;
      } else {
        return true;
      }
    }
  }
