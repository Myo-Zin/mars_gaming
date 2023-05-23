class BalanceTransferHistoryResponse {
  List<BalanceTransferHistory>? balanceTransferHistories;

  BalanceTransferHistoryResponse({this.balanceTransferHistories});

  BalanceTransferHistoryResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      balanceTransferHistories = <BalanceTransferHistory>[];
      json['data'].forEach((v) {
        balanceTransferHistories!.add(BalanceTransferHistory.fromJson(v));
      });
    }
  }
}

class BalanceTransferHistory {
  int? id;
  int? userId;
  String? referenceid;
  String? message;
  String? errorCode;
  String? gameBalance;
  String? mainBalance;
  String? transferBalance;
  String? createdAt;
  String? updatedAt;

  BalanceTransferHistory(
      {this.id,
      this.userId,
      this.referenceid,
      this.message,
      this.errorCode,
      this.gameBalance,
      this.mainBalance,
      this.transferBalance,
      this.createdAt,
      this.updatedAt});

  BalanceTransferHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    referenceid = json['referenceid'];
    message = json['message'];
    errorCode = json['error_code'];
    gameBalance = json['game_balance'];
    mainBalance = json['main_balance'] ?? json['balance'];
    transferBalance = json['transfer_balance'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
