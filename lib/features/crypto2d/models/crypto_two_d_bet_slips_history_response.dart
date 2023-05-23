class CryptoTwoDBetSlipHistoryResponse {
  int? status;
  String? message;
  List<BetSlip>? data;

  CryptoTwoDBetSlipHistoryResponse({this.status, this.message, this.data});

  CryptoTwoDBetSlipHistoryResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <BetSlip>[];
      json['data'].forEach((v) {
        data!.add(BetSlip.fromJson(v));
      });
    }
  }
}

class BetSlip {
  int? id;
  int? userId;
  String? section;
  int? read;
  int? reward;
  int? rewardAmount;
  int? totalAmount;
  int? totalBet;
  int? win;
  int? claim;
  int? notiOn;
  int? referralId;
  String? date;
  String? createdAt;
  String? updatedAt;
  List<Betting>? bettings;

  BetSlip({
    this.id,
    this.userId,
    this.section,
    this.read,
    this.reward,
    this.rewardAmount,
    this.totalAmount,
    this.totalBet,
    this.win,
    this.claim,
    this.notiOn,
    this.referralId,
    this.date,
    this.createdAt,
    this.updatedAt,
    this.bettings,
  });

  BetSlip.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    section = json['section'];
    read = json['read'];
    reward = json['reward'];
    rewardAmount = json['reward_amount'];
    totalAmount = json['total_amount'];
    totalBet = json['total_bet'];
    win = json['win'];
    claim = json['claim'];
    notiOn = json['noti_on'];
    referralId = json['referral_id'];
    date = json['date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['bettings_c2d'] != null) {
      bettings = <Betting>[];
      json['bettings_c2d'].forEach((v) {
        bettings!.add(Betting.fromJson(v));
      });
    }
  }
}

class Betting {
  int? id;
  int? betId;
  String? betNumber;
  String? amount;
  int? odd;
  int? categoryId;
  String? section;
  String? date;
  int? win;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;

  Betting(
      {this.id,
      this.betId,
      this.betNumber,
      this.amount,
      this.odd,
      this.categoryId,
      this.section,
      this.date,
      this.win,
      this.createdAt,
      this.updatedAt,
      this.pivot});

  Betting.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    betId = json['bet_id'];
    betNumber = json['bet_number'];
    amount = json['amount'];
    odd = json['odd'];
    categoryId = json['category_id'];
    section = json['section'];
    date = json['date'];
    win = json['win'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
  }
}

class Pivot {
  int? userBetId;
  int? bettingId;

  Pivot({this.userBetId, this.bettingId});

  Pivot.fromJson(Map<String, dynamic> json) {
    userBetId = json['user_bet_id'];
    bettingId = json['betting_id'];
  }
}
