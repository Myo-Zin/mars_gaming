class BannerResponse {
  BannerResponse({
      this.result, 
      this.status, 
      this.message, 
      this.banner,});

  BannerResponse.fromJson(dynamic json) {
    result = json['result'];
    status = json['status'];
    message = json['message'];
    if (json['banner'] != null) {
      banner = [];
      json['banner'].forEach((v) {
        banner?.add(BannerProduct.fromJson(v));
      });
    }
  }
  int? result;
  int? status;
  String? message;
  List<BannerProduct>? banner;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['result'] = result;
    map['status'] = status;
    map['message'] = message;
    if (banner != null) {
      map['banner'] = banner?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}
class BannerProduct {
  BannerProduct({
    this.mbImage,});

  BannerProduct.fromJson(dynamic json) {
    mbImage = json['mb_image'];
  }
  String? mbImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mb_image'] = mbImage;
    return map;
  }

}