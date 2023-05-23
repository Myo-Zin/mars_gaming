import 'three_d.dart';

class ThreeDResponse {

  int? status;
  String? message;
  String? overallAmount;
  String? defaultAmount;
  int? odd;
  int? tot;
  String? game;
  List<ThreeD>? data;
  ThreeDResponse({
      this.status, 
      this.message, 
      this.overallAmount, 
      this.defaultAmount, 
      this.odd, 
      this.tot, 
      this.game, 
      this.data,});

  ThreeDResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    overallAmount = json['overall_amount'];
    defaultAmount = json['default_amount'];
    odd = json['odd'];
    tot = json['tot'];
    game = json['game'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ThreeD.fromJson(
          json: v,
          overAllAmount: json['overall_amount'],
          ddtAmount: json['default_amount'],
          oddPercent: json['odd'],
        ));
      });
    }
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    map['overall_amount'] = overallAmount;
    map['default_amount'] = defaultAmount;
    map['odd'] = odd;
    map['tot'] = tot;
    map['game'] = game;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}