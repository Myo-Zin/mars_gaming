class GameReportResponse {
  List<GameReport>? data;
  GrandTotal? grandTotal;

  GameReportResponse({this.data, this.grandTotal});

  GameReportResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <GameReport>[];
      json['data'].forEach((v) {
        data!.add(GameReport.fromJson(v));
      });
    }
    grandTotal = json['grand_total'] != null
        ? GrandTotal.fromJson(json['grand_total'])
        : null;
  }
}

class GameReport {
  String? date;
  List<ProviderData>? providerData;
  Totalbydate? totalbydate;

  GameReport({this.date, this.providerData, this.totalbydate});

  GameReport.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    if (json['provider_data'] != null) {
      providerData = <ProviderData>[];
      json['provider_data'].forEach((v) {
        providerData!.add(ProviderData.fromJson(v));
      });
    }
    totalbydate = json['totalbydate'] != null
        ? Totalbydate.fromJson(json['totalbydate'])
        : null;
  }
}

class ProviderData {
  String? provider;
  String? pCode;
  String? totalTurnover;
  String? totalCommission;
  String? totalWinloss;
  String? totalProfitloss;

  ProviderData(
      {this.provider,
      this.pCode,
      this.totalTurnover,
      this.totalCommission,
      this.totalWinloss,
      this.totalProfitloss});

  ProviderData.fromJson(Map<String, dynamic> json) {
    provider = json['provider'];
    pCode = json['p_code'];
    totalTurnover = json['total_turnover'].toString();
    totalCommission = json['total_commission'].toString();
    totalWinloss = json['total_winloss'].toString();
    totalProfitloss = json['total_profitloss'].toString();
  }
}

class Totalbydate {
  String? turnover;
  String? winloss;
  String? commission;
  String? profitloss;

  Totalbydate({
    this.turnover,
    this.winloss,
    this.commission,
    this.profitloss,
  });

  Totalbydate.fromJson(Map<String, dynamic> json) {
    turnover = json['turnover'].toString();
    winloss = json['winloss'].toString();
    commission = json['commission'].toString();
    profitloss = json['profitloss'].toString();
  }
}

class GrandTotal {
  String? turnover;
  String? winloss;
  String? commission;
  String? profitloss;

  GrandTotal({
    this.turnover,
    this.winloss,
    this.commission,
    this.profitloss,
  });

  GrandTotal.fromJson(Map<String, dynamic> json) {
    turnover = json['turnover'].toString();
    winloss = json['winloss'].toString();
    commission = json['commission'].toString();
    profitloss = json['profitloss'].toString();
  }
}
