import 'crypto_two_d.dart';

class CryptoTwoDResponse {
  int? status;
  String? message;
  String? overallAmount;
  String? defaultAmount;
  int? odd;
  String? game;
  List<CryptoTwoD>? data;

  CryptoTwoDResponse({
    this.status,
    this.message,
    this.overallAmount,
    this.defaultAmount,
    this.odd,
    this.game,
    this.data,
  });

  CryptoTwoDResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    overallAmount = json['overall_amount'];
    defaultAmount = json['default_amount'];
    odd = json['odd'];
    game = json['game'];
    if (json['data'] != null) {
      data = <CryptoTwoD>[];
      json['data'].forEach(
        (td) {
          data!.add(
            CryptoTwoD.fromJson(
              json: td,
              overAllAmount: json['overall_amount'],
              oddPercent: json['odd'],
            ),
          );
        },
      );
    }
  }
}
