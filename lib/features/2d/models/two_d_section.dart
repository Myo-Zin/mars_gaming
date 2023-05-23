class TwoDSection {
  int? id;
  String? timeSection;
  String? openTime;
  String? closeTime;
  String? createdAt;
  String? updatedAt;

  TwoDSection({
    this.id,
    this.timeSection,
    this.openTime,
    this.closeTime,
    this.createdAt,
    this.updatedAt,
  });

  TwoDSection.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    timeSection = json['time_section'];
    openTime = json['open_time'];
    closeTime = json['close_time'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
