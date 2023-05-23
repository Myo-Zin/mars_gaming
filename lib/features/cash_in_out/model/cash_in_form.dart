class CashInForm {
  final int userid;
  final int paymentid;
  final String accountname;
  final String transactionid;
  final int amount;
  final String holderPhone;
  final String userphone;
  final int? promoid;
  CashInForm({
    required this.userid,
    required this.paymentid,
    required this.accountname,
    required this.transactionid,
    required this.amount,
    required this.holderPhone,
    required this.userphone,
    required this.promoid,
  });

  CashInForm copyWith({
    int? userid,
    int? paymentid,
    String? accountname,
    String? transactionid,
    int? amount,
    String? holderphone,
    String? userphone,
    int? promoid,
  }) {
    return CashInForm(
      userid: userid ?? this.userid,
      paymentid: paymentid ?? this.paymentid,
      accountname: accountname ?? this.accountname,
      transactionid: transactionid ?? this.transactionid,
      amount: amount ?? this.amount,
      holderPhone: holderphone ?? holderPhone,
      userphone: userphone ?? this.userphone,
      promoid: promoid ?? this.promoid,
    );
  }
}
