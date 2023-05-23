

import 'crypto_two_d_section.dart';

class CryptoTwoDSectionResponse {
  int? result;
  int? status;
  bool? isOpenedToday;
  String? message;
  List<CryptoTwoDSection>? data;

  CryptoTwoDSectionResponse(
      {this.result, this.status, this.isOpenedToday, this.message, this.data});

  CryptoTwoDSectionResponse.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    status = json['status'];
    isOpenedToday = json['is_opened_today'];
    message = json['message'];
    if (json['data'] != null) {
      data =  <CryptoTwoDSection>[];
      json['data'].forEach((v) {
        data?.add(CryptoTwoDSection.fromJson(v));
      });
    }
  }

}
