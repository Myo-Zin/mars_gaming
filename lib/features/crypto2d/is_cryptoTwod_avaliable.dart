  import 'models/crypto_two_d.dart';

bool isCryptoTwoDAvailable(CryptoTwoD cryptoTwoD) {
    if (cryptoTwoD.block == true) {
      return false;
    }
    final minAmount = cryptoTwoD.defaultAmount ?? 0;
    final hotAmount = cryptoTwoD.hotAmount ?? 0.0;
    final totalAmount = cryptoTwoD.totalAmount ?? 0.0;
    final overAllAmount = cryptoTwoD.overallAmount ?? 0.0;
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
