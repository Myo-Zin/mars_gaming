
import 'package:mars_gaming/features/3d/models/three_d_bet_slip.dart';

class ThreeDBetSlipResponse{
  ThreeDBetSlipResponse({
      this.status, 
      this.message, 
      this.tot, 
      this.data,});

  ThreeDBetSlipResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    tot = json['tot'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ThreeDBetSlip.fromJson(v));
      });
    }
  }
  int? status;
  String? message;
  int? tot;
  List<ThreeDBetSlip>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    map['tot'] = tot;
    map['data'] = data?.map((v) => v.toJson()).toList();
    return map;
  }

}