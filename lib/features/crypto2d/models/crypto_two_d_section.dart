
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['time_section'] = this.timeSection;
    data['open_time'] = this.openTime;
    data['close_time'] = this.closeTime;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}