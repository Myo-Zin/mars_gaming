// class CryptoTwoDLuckyNumber {
//   String? s2d;
//   String? section;
//
//   CryptoTwoDLuckyNumber({this.s2d, this.section});
//
//   CryptoTwoDLuckyNumber.fromJson(Map<String, dynamic> json) {
//     s2d = json['c2d'];
//     section = json['section'];
//   }
// }
import 'package:firebase_database/firebase_database.dart';

class CryptoTwoDLuckyNumber {
  String? c2d;
  String? buy;
  String? sell;
  String? time;

  CryptoTwoDLuckyNumber({this.c2d, this.buy, this.sell, this.time});

  CryptoTwoDLuckyNumber.fromJson(Map<dynamic, dynamic> json) {
    c2d = json['2d'];
    buy = json['buy'];
    sell = json['sell'];
    time = json['time'];
  }

  toJson() {
    return {
      "2d": c2d,
      "buy": buy,
      "sell": sell,
      "time": time,
    };
  }
}
