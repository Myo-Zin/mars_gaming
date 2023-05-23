

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/crypto_two_d_section.dart';
import '../repositories/crypto_two_d_repository.dart';


class CryptoTwoDSectionNotifier extends StateNotifier<AsyncValue<List<CryptoTwoDSection>>> {
  CryptoTwoDSectionNotifier(this.repository) : super(const AsyncLoading()) {
    getTwoDSection();
  }
  final CryptoTwoDRepository repository;

  Future<void> getTwoDSection() async {
    final result = await repository.getCryptoTwoDSectionList();
    state = result.fold(
      (l) => AsyncError(l.message, StackTrace.empty),
      (r) => AsyncData(r),
    );
  }
}
