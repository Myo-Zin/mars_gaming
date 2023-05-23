

class WinnerResponse {
  WinnerResponse({
      this.data, 
      this.section, 
      this.openDate, 
      this.luckyNumber,});

  WinnerResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Winner.fromJson(v));
      });
    }
    section = json['section'];
    openDate = json['open_date'];
    luckyNumber = json['lucky_number'];
  }
  List<Winner>? data;
  String? section;
  String? openDate;
  String? luckyNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['section'] = section;
    map['open_date'] = openDate;
    map['lucky_number'] = luckyNumber;
    return map;
  }

}

class Winner {
  Winner({
    this.id,
    this.winAmount,
    this.betAmount,
    this.name,
    this.phone,
    this.section,
    this.openDate,
    this.luckyNumber,});

  Winner.fromJson(dynamic json) {
    id = json['id'];
    winAmount = json['win_amount'];
    betAmount = json['bet_amount'];
    name = json['name'];
    phone = json['phone'];
    section = json['section'];
    openDate = json['open_date'];
    luckyNumber = json['lucky_number'];
  }
  int? id;
  int? winAmount;
  int? betAmount;
  String? name;
  String? phone;
  String? section;
  String? openDate;
  String? luckyNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['win_amount'] = winAmount;
    map['bet_amount'] = betAmount;
    map['name'] = name;
    map['phone'] = phone;
    map['section'] = section;
    map['open_date'] = openDate;
    map['lucky_number'] = luckyNumber;
    return map;
  }

}