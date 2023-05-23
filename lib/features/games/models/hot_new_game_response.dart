class HotNewGameResponse {
  String? message;
  List<HotNewGame>? data;

  HotNewGameResponse({this.message, this.data});

  HotNewGameResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <HotNewGame>[];
      json['data'].forEach((v) {
        data!.add(HotNewGame.fromJson(v));
      });
    }
  }
}

class HotNewGame {
  int? id;
  String? gCode;
  String? name;
  int? providerId;
  int? categoryId;
  String? htmlType;
  int? active;
  String? img;
  int? isHot;
  int? isNew;
  int? isGamepage;
  String? createdAt;
  String? updatedAt;

  HotNewGame(
      {this.id,
      this.gCode,
      this.name,
      this.providerId,
      this.categoryId,
      this.htmlType,
      this.active,
      this.img,
      this.isHot,
      this.isNew,
      this.isGamepage,
      this.createdAt,
      this.updatedAt});

  HotNewGame.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gCode = json['g_code'];
    name = json['name'];
    providerId = json['provider_id'];
    categoryId = json['category_id'];
    htmlType = json['html_type'];
    active = json['active'];
    img = json['img'];
    isHot = json['is_hot'];
    isNew = json['is_new'];
    isGamepage = json['is_gamepage'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
