import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../profile/providers/providers.dart';
import '../repositories/wallet_repository.dart';

class WalletTransferNotifier extends StateNotifier<AsyncValue<void>> {
  WalletTransferNotifier(
    this.ref,
    this.repository,
  ) : super(const AsyncData(null));

  final WalletRepository repository;
  final Ref ref;

  Future<void> mainToGameTransfer(String token, int amount) async {
    state = const AsyncLoading();
    final result = await repository.mainToGame(token, amount);

    state = result.fold(
      (l) => AsyncError(l.message, StackTrace.empty),
      (r) => const AsyncData(null),
    );
    ref.read(profileControllerProvider.notifier).refreshProfile();
  }

  Future<void> gameToMainTransfer(String token, int amount) async {
    state = const AsyncLoading();
    final result = await repository.gameToMain(token, amount);
    state = result.fold(
      (l) => AsyncError(l.message, StackTrace.empty),
      (r) => const AsyncData(null),
    );
    ref.read(profileControllerProvider.notifier).refreshProfile();
  }
}
