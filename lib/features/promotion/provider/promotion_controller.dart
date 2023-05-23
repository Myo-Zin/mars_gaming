

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/promotin_response.dart';
import '../repositories/promotion_repository.dart';


class PromotionNotifier extends StateNotifier<AsyncValue<List<Promotion>>> {
  PromotionNotifier(this.ref,
      this.repository,) : super(const AsyncLoading()){
    getPromotion();
  }

  final PromotionRepository repository;
  final Ref ref;

  Future<void> getPromotion() async {
    final result = await repository.getPromotion();
    state = result.fold(
          (l) => AsyncError(l.message, StackTrace.empty),
          (r) => AsyncData(r),
    );

    //ref.read(profileControllerProvider.notifier).refreshProfile();
  }


}