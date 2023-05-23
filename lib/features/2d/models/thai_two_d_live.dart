class ThaiTwoDLive {
  String? set;
  String? value;
  String? twod;
  String? time;

  ThaiTwoDLive({this.set, this.value, this.twod, this.time});

  ThaiTwoDLive.fromJson(Map<String, dynamic> json) {
    set = json['set'];
    value = json['value'];
    twod = json['twod'];
    time = json['time'];
  }
}
