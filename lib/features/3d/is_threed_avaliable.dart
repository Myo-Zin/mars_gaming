
import 'models/three_d.dart';

bool isThreeDAvalible(ThreeD threeD) {
  if (threeD.block != "no") {
    return false;
  }
  final minAmount = threeD.defaultAmount ?? 0;
  final hotAmount = threeD.hotAmount ?? 0.0;
  final totalAmount = threeD.totalAmount ?? 0.0;
  final overAllAmount = threeD.overallAmount ?? 0.0;
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
