class GameReportDetailParam {
  final String date;
  final String provider;
  final String usercode;
  final String token;
  GameReportDetailParam({
    required this.date,
    required this.provider,
    required this.usercode,
    required this.token,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GameReportDetailParam &&
        other.date == date &&
        other.provider == provider &&
        other.usercode == usercode &&
        other.token == token;
  }

  @override
  int get hashCode {
    return date.hashCode ^
        provider.hashCode ^
        usercode.hashCode ^
        token.hashCode;
  }
}
