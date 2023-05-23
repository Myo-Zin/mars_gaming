class CashInHistoryResponse {
  List<CashInHistory>? cashInHistories;

  CashInHistoryResponse({this.cashInHistories});

  CashInHistoryResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      cashInHistories = <CashInHistory>[];
      json['data'].forEach((v) {
        cashInHistories!.add(CashInHistory.fromJson(v));
      });
    }
  }
}

class CashInHistory {
  int? id;
  int? userId;
  int? paymentId;
  int? promoId;
  int? promoPercent;
  String? accountName;
  int? transactionId;
  String? userPhone;
  String? message;
  String? status;
  double? amount;
  String? holderPhone;
  double? oldAmount;
  int? superAdminId;
  int? seniorAgentId;
  int? masterAgentId;
  int? agentId;
  String? date;
  String? time;
  String? createdAt;
  String? updatedAt;

  CashInHistory(
      {this.id,
      this.userId,
      this.paymentId,
      this.promoId,
      this.promoPercent,
      this.accountName,
      this.transactionId,
      this.userPhone,
      this.message,
      this.status,
      this.amount,
      this.holderPhone,
      this.oldAmount,
      this.superAdminId,
      this.seniorAgentId,
      this.masterAgentId,
      this.agentId,
      this.date,
      this.time,
      this.createdAt,
      this.updatedAt});

  CashInHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    paymentId = json['payment_id'];
    promoId = json['promo_id'];
    promoPercent = json['promo_percent'];
    accountName = json['account_name'];
    transactionId = json['transaction_id'];
    userPhone = json['user_phone'];
    message = json['message'];
    status = json['status'];
    amount = double.parse(json['amount'] ?? "0");
    holderPhone = json['holder_phone'];
    oldAmount = double.parse(json['old_amount'] ?? '0');
    superAdminId = json['super_admin_id'];
    seniorAgentId = json['senior_agent_id'];
    masterAgentId = json['master_agent_id'];
    agentId = json['agent_id'];
    date = json['date'];
    time = json['time'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
