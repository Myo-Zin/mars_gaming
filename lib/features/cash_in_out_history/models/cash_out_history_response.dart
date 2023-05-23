class CashOutHistoryResponse {
  List<CashOutHistory>? cashOutHistories;

  CashOutHistoryResponse({this.cashOutHistories});

  CashOutHistoryResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      cashOutHistories = <CashOutHistory>[];
      json['data'].forEach((v) {
        cashOutHistories!.add(CashOutHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cashOutHistories != null) {
      data['data'] = cashOutHistories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CashOutHistory {
  int? id;
  int? userId;
  int? paymentId;
  String? accountName;
  String? userPhone;
  String? message;
  String? status;
  String? amount;
  String? oldAmount;
  int? superAdminId;
  int? seniorAgentId;
  int? masterAgentId;
  int? agentId;
  String? date;
  String? time;
  String? createdAt;
  String? updatedAt;

  CashOutHistory(
      {this.id,
      this.userId,
      this.paymentId,
      this.accountName,
      this.userPhone,
      this.message,
      this.status,
      this.amount,
      this.oldAmount,
      this.superAdminId,
      this.seniorAgentId,
      this.masterAgentId,
      this.agentId,
      this.date,
      this.time,
      this.createdAt,
      this.updatedAt});

  CashOutHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    paymentId = json['payment_id'];
    accountName = json['account_name'];
    userPhone = json['user_phone'];
    message = json['message'];
    status = json['status'];
    amount = json['amount'];
    oldAmount = json['old_amount'];
    superAdminId = json['super_admin_id'];
    seniorAgentId = json['senior_agent_id'];
    masterAgentId = json['master_agent_id'];
    agentId = json['agent_id'];
    date = json['date'];
    time = json['time'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['payment_id'] = paymentId;
    data['account_name'] = accountName;
    data['user_phone'] = userPhone;
    data['message'] = message;
    data['status'] = status;
    data['amount'] = amount;
    data['old_amount'] = oldAmount;
    data['super_admin_id'] = superAdminId;
    data['senior_agent_id'] = seniorAgentId;
    data['master_agent_id'] = masterAgentId;
    data['agent_id'] = agentId;
    data['date'] = date;
    data['time'] = time;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
