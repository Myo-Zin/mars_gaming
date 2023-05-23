

class CryptoTwoDLuckyNumHistoryResponse {
  CryptoTwoDLuckyNumHistoryResponse({
      this.data,});

  CryptoTwoDLuckyNumHistoryResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(CryptoTwoDLuckyNumHistory.fromJson(v));
      });
    }
  }
  List<CryptoTwoDLuckyNumHistory>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['data'] = data?.map((v) => v.toJson()).toList();
    return map;
  }

}

class CryptoTwoDLuckyNumHistory {
  CryptoTwoDLuckyNumHistory({
    this.id,
    this.luckyNumber,
    this.set,
    this.value,
    this.modern,
    this.internet,
    this.section,
    this.categoryId,
    this.createDate,
    this.read,
    this.approve,
    this.createdAt,
    this.updatedAt,});

  CryptoTwoDLuckyNumHistory.fromJson(dynamic json) {
    id = json['id'];
    luckyNumber = json['lucky_number'];
    set = json['set'];
    value = json['value'];
    modern = json['modern'];
    internet = json['internet'];
    section = json['section'];
    categoryId = json['category_id'];
    createDate = json['create_date'];
    read = json['read'];
    approve = json['approve'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  String? luckyNumber;
  String? set;
  String? value;
  dynamic modern;
  dynamic internet;
  String? section;
  int? categoryId;
  String? createDate;
  int? read;
  int? approve;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['lucky_number'] = luckyNumber;
    map['set'] = set;
    map['value'] = value;
    map['modern'] = modern;
    map['internet'] = internet;
    map['section'] = section;
    map['category_id'] = categoryId;
    map['create_date'] = createDate;
    map['read'] = read;
    map['approve'] = approve;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}