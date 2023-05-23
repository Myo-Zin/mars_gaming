
class GamesResponse {
  List<Game>? data;

  GamesResponse({this.data});

  GamesResponse.fromJson(List<dynamic>? list) {
    if (list != null) {
      data = <Game>[];
      data = list.map((e) => Game.fromJson(e)).toList();
    }
  }
}


class Game {
  int? id;
  String? name;
  String? img;
  String? gCode;
  int? active;
  int? providerId;

  Game(
      {this.id, this.name, this.img, this.gCode, this.active, this.providerId});

  Game.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    img = json['img'];
    gCode = json['g_code'];
    active = json['active'];
    providerId = json['provider_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['img'] = img;
    data['g_code'] = gCode;
    data['active'] = active;
    data['provider_id'] = providerId;
    return data;
  }
}
