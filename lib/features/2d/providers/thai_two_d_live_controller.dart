import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/thai_two_d_live.dart';
import '../repositories/two_d_repository.dart';


class ThaiTwoDLiveNotifier extends StateNotifier<AsyncValue<ThaiTwoDLive>> {
  ThaiTwoDLiveNotifier(this.repository) : super(const AsyncLoading()) {
    getThaiTwoDLive();
    timer = Timer.periodic(
      const Duration(seconds: 5),
      (_) {
        getThaiTwoDLive();
      },
    );
  }
  final TwoDRepository repository;
  Timer? timer;

  Future<void> getThaiTwoDLive() async {
    final result = await repository.getThaiTwoDLive();
    if (mounted) {
      state = result.fold(
        (l) => AsyncError(l.message, StackTrace.empty),
        (r) => AsyncData(r),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
