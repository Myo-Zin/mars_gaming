class GameReportDetail {
  String? username;
  String? betTime;
  String? bizDate;
  String? gametype;
  String? bet;
  String? turnover;
  String? win;
  String? winloss;
  String? commission;
  String? profitloss;
  String? createdAt;

  GameReportDetail(
      {this.username,
      this.betTime,
      this.bizDate,
      this.gametype,
      this.bet,
      this.turnover,
      this.win,
      this.winloss,
      this.commission,
      this.profitloss,
      this.createdAt});

  GameReportDetail.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    betTime = json['bet_time'];
    bizDate = json['biz_date'];
    gametype = json['gametype'];
    bet = json['bet'];
    turnover = json['turnover'].toString();
    win = json['win'].toString();
    winloss = json['winloss'].toString();
    commission = json['commission'].toString();
    profitloss = json['profitloss'].toString();
    createdAt = json['created_at'];
  }
}
