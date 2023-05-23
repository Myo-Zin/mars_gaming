import 'two_d.dart';

class TwoDResponse {
  int? status;
  String? message;
  String? overallAmount;
  String? defaultAmount;
  int? odd;
  String? game;
  List<TwoD>? data;

  TwoDResponse({
    this.status,
    this.message,
    this.overallAmount,
    this.defaultAmount,
    this.odd,
    this.game,
    this.data,
  });

  TwoDResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    overallAmount = json['overall_amount'];
    defaultAmount = json['default_amount'];
    odd = json['odd'];
    game = json['game'];
    if (json['data'] != null) {
      data = <TwoD>[];
      json['data'].forEach(
        (td) {
          data!.add(
            TwoD.fromJson(
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
