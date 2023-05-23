class TwoDLuckyNumber {
  String? s2d;
  String? section;

  TwoDLuckyNumber({this.s2d, this.section});

  TwoDLuckyNumber.fromJson(Map<String, dynamic> json) {
    s2d = json['2d'];
    section = json['section'];
  }
}
