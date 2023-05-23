import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/dio_provider.dart';
import '../repositories/wallet_repository.dart';
import '../services/wallet_service.dart';
import 'wallet_transfer_controller.dart';


final walletServiceProvider =
    Provider((ref) => WalletService(ref.read(dioProvider)));

final wallRepositoryProvider =
    Provider((ref) => WalletRepository(ref.read(walletServiceProvider)));

final walletTransferController =
    StateNotifierProvider.autoDispose<WalletTransferNotifier, AsyncValue<void>>(
        (ref) {
  return WalletTransferNotifier(ref, ref.read(wallRepositoryProvider));
});
