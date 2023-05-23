
import '../../../core/enum.dart';

class GameByCategoryIdParam {
  final GameType gameType;
  final int? categoryId;
  GameByCategoryIdParam({
    required this.gameType,
    required this.categoryId,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GameByCategoryIdParam &&
        other.gameType == gameType &&
        other.categoryId == categoryId;
  }

  @override
  int get hashCode => gameType.hashCode ^ categoryId.hashCode;

  @override
  String toString() =>
      'GameByCategoryIdParam(url: $gameType, categoryId: $categoryId)';
}
