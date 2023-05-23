

import 'package:equatable/equatable.dart';

class DateState extends Equatable {
  final int? userId;
  final String? startDate;
  final String? endDate;
  final String? token;
  final String? title;
  final String? type;

  const DateState({
    this.userId,
    this.startDate,
    this.endDate,
    this.token,
    this.title,
    this.type,
  });

  const DateState.empty()
      : userId = null,
        startDate = null,
        title = null,
        endDate = null,
        token = null,
        type  = null;

  @override
  List<Object?> get props => [userId, startDate, endDate, token, title,type,];

  DateState copyWith({
    int? userId,
    String? startDate,
    String? endDate,
    String? token,
    String? title,
    String? type,
  }) {
    return DateState(
      userId: userId ?? this.userId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      token: token ?? this.token,
      title: title ?? this.title,
      type: type ?? this.type,
    );
  }

  bool get isEmpty =>
      userId == null ||
      startDate == null ||
      endDate == null ||
      token == null ||
      title == null ||
      type == null;

  @override
  String toString() {
    return 'DateState(userId: $userId, startDate: $startDate, endDate: $endDate, token: $token , title: $title, type: $type)';
  }
}
