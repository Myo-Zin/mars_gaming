class ThreeDSection {
  String? date3d;
  String? section;
  String? close;
  String? openDate;

  ThreeDSection({this.date3d, this.section,this.openDate, this.close});

  ThreeDSection.fromJson(Map<String, dynamic> json) {
    date3d = json['date_3d'];
    section = json['section'];
    close = json['close'];
    openDate = json['opening_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date_3d'] = date3d;
    data['section'] = section;
    data['close'] = close;
    data['opening_date'] = openDate;
    return data;
  }

  @override
  String toString() =>
      'ThreeDSection(date3d: $date3d, section: $section,openDate$openDate, close: $close)';
}
