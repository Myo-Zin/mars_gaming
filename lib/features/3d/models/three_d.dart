class ThreeD {
  int? id;
  String? betNumber;
  double? defaultAmount;
  double? overallAmount;
  int? totalAmount;
  int? hotAmount;
  double? betAmount;
  String? block;
  int? odd;
  String? section;
  bool? isSelected;
  bool? isGetExpectedAmount;

  ThreeD({
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

  ThreeD.fromJson(
      {required Map<String, dynamic> json,
      required String overAllAmount,
      required int oddPercent,
      required String ddtAmount}) {
    id = json['id'];
    betNumber = json['bet_number'];
    defaultAmount = double.parse(ddtAmount);
    totalAmount = json['total_amount'];
    hotAmount = json['hot_amount'];
    block = json['block'];
    overallAmount = double.parse(overAllAmount);
    odd = oddPercent;
    isSelected = false;
    isGetExpectedAmount = true;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['bet_number'] = betNumber;
    map['total_amount'] = totalAmount;
    map['hot_amount'] = hotAmount;
    map['block'] = block;
    return map;
  }

  toBetObject(String section, String date3d) {
    return {
      "bet_number": betNumber,
      "amount": betAmount,
      "odd": odd,
      "category_id": 2,
      "section": section,
      "date_3d": date3d,
    };
  }

  ThreeD copyWith({
    int? id,
    String? betNumber,
    double? defaultAmount,
    int? totalAmount,
    double? overallAmount,
    int? hotAmount,
    double? betAmount,
    int? odd,
    String? block,
    String? section,
    bool? isSelected,
    bool? isGetExpectedAmount,
  }) {
    return ThreeD(
      id: id ?? this.id,
      betNumber: betNumber ?? this.betNumber,
      defaultAmount: defaultAmount ?? this.defaultAmount,
      totalAmount: totalAmount ?? this.totalAmount,
      overallAmount: overallAmount ?? this.overallAmount,
      hotAmount: hotAmount ?? this.hotAmount,
      betAmount: betAmount ?? this.betAmount,
      odd: odd ?? this.odd,
      block: block ?? this.block,
      section: section ?? this.section,
      isSelected: isSelected ?? this.isSelected,
      isGetExpectedAmount: isGetExpectedAmount ?? this.isGetExpectedAmount,
    );
  }

  @override
  String toString() {
    return 'ThreeDigit(id: $id, betNumber: $betNumber, defaultAmount: $defaultAmount, totalAmount: $totalAmount, hotAmount: $hotAmount,betAmount: $betAmount,odd: $odd, block: $block, isSelected: $isSelected)';
  }
}
