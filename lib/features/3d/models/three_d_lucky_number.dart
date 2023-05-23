
class ThreeDLuckyNumber {
  ThreeDLuckyNumber({
      this.luckynumber,
      this.date,});

  ThreeDLuckyNumber.fromJson(dynamic json) {
    luckynumber = json['lucky number'];
    date = json['date'];
  }
  String? luckynumber;
  String? date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lucky number'] = luckynumber;
    map['date'] = date;
    return map;
  }

}