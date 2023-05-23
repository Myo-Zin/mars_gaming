

import '../../profile/models/profile_response.dart';

class ReferralHistoryResponse {
  ReferralHistoryResponse({
      this.totalAmount,
      this.data,});

  ReferralHistoryResponse.fromJson(dynamic json) {
    totalAmount = json['total amount'].toString();
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(ReferralHistoryData.fromJson(v));
      });
    }
  }
  String? totalAmount;
  List<ReferralHistoryData>? data;

}
class ReferralHistoryData {
  ReferralHistoryData({
    this.amount,
    this.section,
    this.referralId,
    this.createdAt,
    this.user,});

  ReferralHistoryData.fromJson(dynamic json) {
    amount = json['amount'];
    section = json['section'];
    referralId = json['referral_id'];
    createdAt = json['created_at'];
    user = json['user'] != null ? ProfileData.fromJson(json['user']) : null;
  }
  String? amount;
  String? section;
  int? referralId;
  String? createdAt;
  ProfileData? user;

}