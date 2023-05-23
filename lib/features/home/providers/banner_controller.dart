import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/banner_reponse.dart';
import '../repositories/home_repository.dart';


class BannerNotifier extends StateNotifier<AsyncValue<List<BannerProduct>>> {
  final HomeRepository _homeRepository;
  BannerNotifier(this._homeRepository) : super(const AsyncLoading()) {
    getBanner();
  }

  Future<void> getBanner() async {
    final resp = await _homeRepository.getBanner();

    state = resp.fold(
          (e) => AsyncValue.error(e.message, StackTrace.empty),
          (banners) => AsyncValue.data(banners),
    );
  }
}
