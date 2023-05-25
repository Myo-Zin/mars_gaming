import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/crypto_two_d.dart';
import '../repositories/crypto_two_d_repository.dart';

class CryptoTwoDBetNotifier extends StateNotifier<AsyncValue<void>> {
  CryptoTwoDBetNotifier(this.repository) : super(const AsyncData(null));
  final CryptoTwoDRepository repository;

  Future<bool> bet({
    required List<CryptoTwoD> cryptoTwoDList,
    required String section,
    required String token,
  }) async {
    state = const AsyncLoading();
    final result = await repository.betCryptoTwoD(
      cryptoTwoDList: cryptoTwoDList,
      section: section,
      token: token,
    );
    return result.fold(
      (l) {
        state = AsyncError(l.message, StackTrace.empty);

        return false;
      },
      (r) {
        state = const AsyncData(null);
        return true;
      },
    );
  }
}
