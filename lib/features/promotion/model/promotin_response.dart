class PromotionResponse {
  List<Promotion>? data;

  PromotionResponse({this.data});

  PromotionResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Promotion>[];
      json['data'].forEach((v) {
        data!.add(Promotion.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Promotion {
  int? id;
  String? title;
  int? percent;
  String? promoCode;
  int? turnover;
  int? lvl;
  int? status;
  String? gameText;
  String? image;
  String? rule;
  String? createdAt;
  String? updatedAt;

  Promotion(
      {this.id,
      this.title,
      this.percent,
      this.promoCode,
      this.turnover,
      this.lvl,
      this.status,
      this.gameText,
      this.image,
      this.rule,
      this.createdAt,
      this.updatedAt});

  Promotion.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    percent = json['percent'];
    promoCode = json['promo_code'];
    turnover = json['turnover'];
    lvl = json['lvl'];
    status = json['status'];
    gameText = json['game_text'];
    image = json['image'];
    rule = json['rule'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['percent'] = percent;
    data['promo_code'] = promoCode;
    data['turnover'] = turnover;
    data['lvl'] = lvl;
    data['status'] = status;
    data['game_text'] = gameText;
    data['image'] = image;
    data['rule'] = rule;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
