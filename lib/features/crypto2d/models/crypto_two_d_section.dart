class CryptoTwoDSection {
  int? id;
  String? timeSection;
  String? openTime;
  String? closeTime;
  String? createdAt;
  String? updatedAt;

  CryptoTwoDSection(
      {this.id,
      this.timeSection,
      this.openTime,
      this.closeTime,
      this.createdAt,
      this.updatedAt});

  CryptoTwoDSection.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    timeSection = json['time_section'];
    openTime = json['open_time'];
    closeTime = json['close_time'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['time_section'] = timeSection;
    data['open_time'] = openTime;
    data['close_time'] = closeTime;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
