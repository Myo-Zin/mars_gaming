class PaymentMethods {
  List<Pay>? pay;
  List<Pay>? banking;
  List<MobileToUp>? mobileTopUp;

  PaymentMethods({this.pay, this.banking,this.mobileTopUp});

  PaymentMethods.fromJson(Map<String, dynamic> json) {
    if (json['pay'] != null) {
      pay = <Pay>[];
      json['pay'].forEach((v) {
        pay!.add(Pay.fromJson(v));
      });
    }
    if (json['banking'] != null) {
      banking = <Pay>[];
      json['banking'].forEach((v) {
        banking!.add(Pay.fromJson(v));
      });
    }
    if (json['mobile_topup'] != null) {
      mobileTopUp = <MobileToUp>[];
      json['mobile_topup'].forEach((v) {
        mobileTopUp!.add(MobileToUp.fromJson(v));
      });
    }
  }
}

class Pay {
  int? id;
  String? name;
  String? logo;
  List<PaymentAccount>? paymentAccountNumbers;

  Pay({this.id, this.name, this.logo, this.paymentAccountNumbers});

  Pay.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    if (json['payment_account_numbers'] != null) {
      paymentAccountNumbers = <PaymentAccount>[];
      json['payment_account_numbers'].forEach((v) {
        paymentAccountNumbers!.add(PaymentAccount.fromJson(v));
      });
    }
  }
}

class PaymentAccount {
  String? accountNumber;
  String? accountName;

  PaymentAccount({this.accountNumber, this.accountName});

  PaymentAccount.fromJson(Map<String, dynamic> json) {
    accountNumber = json['account_number'];
    accountName = json['account_name'];
  }
}

class MobileToUp {
  MobileToUp({
    this.id,
    this.name,
    this.logo,
    this.percentage,});

  MobileToUp.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    percentage = json['percentage'];
  }
  int? id;
  String? name;
  String? logo;
  int? percentage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['logo'] = logo;
    map['percentage'] = percentage;
    return map;
  }

}