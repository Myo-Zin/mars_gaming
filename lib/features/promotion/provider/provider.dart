import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/dio_provider.dart';
import '../model/promotin_response.dart';
import '../repositories/promotion_repository.dart';
import '../services/promotin_service.dart';
import 'promotion_controller.dart';

final promotionServiceProvider =
    Provider((ref) => PromotionService(ref.read(dioProvider)));

final promotionRepositoryProvider =
    Provider((ref) => PromotionRepository(ref.read(promotionServiceProvider)));

final promotionController = StateNotifierProvider.autoDispose<PromotionNotifier,
    AsyncValue<List<Promotion>>>((ref) {
  return PromotionNotifier(ref, ref.read(promotionRepositoryProvider));
});
