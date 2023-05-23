class CryptoTwoDLive {
  String? buy;
  String? number;
  String? sell;

  CryptoTwoDLive({this.buy, this.number, this.sell,});

  CryptoTwoDLive.fromJson(Map<String, dynamic> json) {
    buy = json['buy'];
    number = json['number'];
    sell = json['sell'];
  }
}
