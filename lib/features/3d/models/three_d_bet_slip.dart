


class ThreeDBetSlip {

  int? id;
  int? userId;
  String? date3d;
  String? section;
  int? read;
  int? reward;
  int? rewardAmount;
  int? totalAmount;
  int? totalBet;
  int? win;
  int? notiOn;
  String? betDate;
  String? date;
  String? createdAt;
  String? updatedAt;
  List<BettingThreeD>? bettings3d;

  ThreeDBetSlip({
    this.id,
    this.userId,
    this.date3d,
    this.section,
    this.read,
    this.reward,
    this.rewardAmount,
    this.totalAmount,
    this.totalBet,
    this.win,
    this.notiOn,
    this.betDate,
    this.date,
    this.createdAt,
    this.updatedAt,
    this.bettings3d,});

  ThreeDBetSlip.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    date3d = json['date_3d'];
    section = json['section'];
    read = json['read'];
    reward = json['reward'];
    rewardAmount = json['reward_amount'];
    totalAmount = json['total_amount'];
    totalBet = json['total_bet'];
    win = json['win'];
    notiOn = json['noti_on'];
    betDate = json['bet_date'];
    date = json['date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['bettings_3d'] != null) {
      bettings3d = [];
      json['bettings_3d'].forEach((v) {
        bettings3d?.add(BettingThreeD.fromJson(v));
      });
    }
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['date_3d'] = date3d;
    map['section'] = section;
    map['read'] = read;
    map['reward'] = reward;
    map['reward_amount'] = rewardAmount;
    map['total_amount'] = totalAmount;
    map['total_bet'] = totalBet;
    map['win'] = win;
    map['noti_on'] = notiOn;
    map['bet_date'] = betDate;
    map['date'] = date;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (bettings3d != null) {
      map['bettings_3d'] = bettings3d?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}
class BettingThreeD {
  BettingThreeD({
      this.id, 
      this.betNumber, 
      this.amount, 
      this.odd, 
      this.categoryId, 
      this.date3d, 
      this.section, 
      this.date, 
      this.betDate, 
      this.win, 
      this.tot, 
      this.totOdd, 
      this.createdAt, 
      this.updatedAt, 
      this.pivot,});

  BettingThreeD.fromJson(dynamic json) {
    id = json['id'];
    betNumber = json['bet_number'];
    amount = json['amount'];
    odd = json['odd'];
    categoryId = json['category_id'];
    date3d = json['date_3d'];
    section = json['section'];
    date = json['date'];
    betDate = json['bet_date'];
    win = json['win'];
    tot = json['tot'];
    totOdd = json['tot_odd'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
  }
  int? id;
  String? betNumber;
  String? amount;
  int? odd;
  int? categoryId;
  String? date3d;
  String? section;
  String? date;
  String? betDate;
  int? win;
  int? tot;
  int? totOdd;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['bet_number'] = betNumber;
    map['amount'] = amount;
    map['odd'] = odd;
    map['category_id'] = categoryId;
    map['date_3d'] = date3d;
    map['section'] = section;
    map['date'] = date;
    map['bet_date'] = betDate;
    map['win'] = win;
    map['tot'] = tot;
    map['tot_odd'] = totOdd;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (pivot != null) {
      map['pivot'] = pivot?.toJson();
    }
    return map;
  }

}




class Pivot {
  Pivot({
    this.userBet3dId,
    this.betting3dId,});

  Pivot.fromJson(dynamic json) {
    userBet3dId = json['user_bet3d_id'];
    betting3dId = json['betting3d_id'];
  }
  int? userBet3dId;
  int? betting3dId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_bet3d_id'] = userBet3dId;
    map['betting3d_id'] = betting3dId;
    return map;
  }

}