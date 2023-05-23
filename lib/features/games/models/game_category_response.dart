class GameCategoryResponse {
  List<GameCategory>? data;

  GameCategoryResponse({this.data});

  GameCategoryResponse.fromJson(List<dynamic>? list) {
    if (list != null) {
      data = <GameCategory>[];
      data = list.map((e) => GameCategory.fromJson(e)).toList();
    }
  }
}

class GameCategory {
  int? id;
  String? name;
  String? pCode;
  String? img;
  int? active;
  String? createdAt;
  String? updatedAt;

  GameCategory({
    this.id,
    this.name,
    this.pCode,
    this.img,
    this.active,
    this.createdAt,
    this.updatedAt,
  });

  GameCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    pCode = json['p_code'];
    img = json['img'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['p_code'] = pCode;
    data['img'] = img;
    data['active'] = active;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
