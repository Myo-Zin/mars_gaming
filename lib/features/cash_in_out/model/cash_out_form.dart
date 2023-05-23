class CashOutForm {
  final int userid;
  final int paymentid;
  final String accountname;
  final int amount;
  final String userphone;
  CashOutForm({
    required this.userid,
    required this.paymentid,
    required this.accountname,
    required this.amount,
    required this.userphone,
  });

  CashOutForm copyWith({
    int? userid,
    int? paymentid,
    String? accountname,
    int? amount,
    String? userphone,
  }) {
    return CashOutForm(
      userid: userid ?? this.userid,
      paymentid: paymentid ?? this.paymentid,
      accountname: accountname ?? this.accountname,
      amount: amount ?? this.amount,
      userphone: userphone ?? this.userphone,
    );
  }
}
