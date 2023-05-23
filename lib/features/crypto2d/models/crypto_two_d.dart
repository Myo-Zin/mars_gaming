class CryptoTwoD {
  int? id;
  String? betNumber;
  double? defaultAmount;
  double? totalAmount;
  double? overallAmount;
  double? hotAmount;
  double? betAmount;
  bool? block;
  int? odd;
  String? section;
  bool? isSelected;
  bool? isGetExpectedAmount;

  CryptoTwoD({
    this.id,
    this.betNumber,
    this.defaultAmount,
    this.totalAmount,
    this.overallAmount,
    this.hotAmount,
    this.betAmount,
    this.block,
    this.odd,
    this.section,
    this.isSelected = false,
    this.isGetExpectedAmount = true,
  });

/// map format for betting to send server api 
  toBetObject() {
    return {
      "bet_id": id,
      "bet_number": betNumber,
      "amount": betAmount,
      "odd": odd,
      "category_id": 1,
      "section": section
    };
  }

  CryptoTwoD.fromJson({
    required Map<String, dynamic> json,
    required String overAllAmount,
    required int oddPercent,
  }) {
    id = json['id'];
    betNumber = json['bet_number'];
    defaultAmount = double.parse(json['default_amount'].toString());
    totalAmount = double.parse(json['total_amount'].toString());
    hotAmount = double.parse(json['hot_amount'].toString());
    overallAmount = double.parse(overAllAmount);
    block = json['block'] != "no";
    odd = oddPercent;
    isSelected = false;
    isGetExpectedAmount = true;
  }

  CryptoTwoD copyWith({
    int? id,
    String? betNumber,
    double? defaultAmount,
    double? totalAmount,
    double? overallAmount,
    double? hotAmount,
    double? betAmount,
    int? odd,
    bool? block,
    String? section,
    bool? isSelected,
    bool? isGetExpectedAmount,
  }) {
    return CryptoTwoD(
      id: id ?? this.id,
      betNumber: betNumber ?? this.betNumber,
      defaultAmount: defaultAmount ?? this.defaultAmount,
      totalAmount: totalAmount ?? this.totalAmount,
      overallAmount: overallAmount ?? this.overallAmount,
      hotAmount: hotAmount ?? this.hotAmount,
      betAmount: betAmount ?? this.betAmount,
      block: block ?? this.block,
      odd: odd ?? this.odd,
      section: section ?? this.section,
      isSelected: isSelected ?? this.isSelected,
      isGetExpectedAmount: isGetExpectedAmount ?? this.isGetExpectedAmount,
    );
  }

  @override
  String toString() {
    return 'CryptoTwoDigit(id: $id, betNumber: $betNumber, defaultAmount: $defaultAmount, totalAmount: $totalAmount, hotAmount: $hotAmount, betAmount: $betAmount, block: $block,odd: $odd,section $section, isSelected: $isSelected, isGetExpectedAmount: $isGetExpectedAmount)';
  }
}
