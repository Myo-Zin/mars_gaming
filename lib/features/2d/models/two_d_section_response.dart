import 'two_d_section.dart';

class TwoDSectionResponse {
  int? result;
  int? status;
  String? message;
  List<TwoDSection>? data;

  TwoDSectionResponse({this.result, this.status, this.message, this.data});

  TwoDSectionResponse.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <TwoDSection>[];
      json['data'].forEach((v) {
        data!.add(TwoDSection.fromJson(v));
      });
    }
  }
}
