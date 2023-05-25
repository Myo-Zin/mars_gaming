import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mars_gaming/features/crypto2d/providers/selected_crypto_two_d_controller.dart';

import '../../../core/providers/date_controller.dart';
import '../../../core/providers/dio_provider.dart';
import '../models/crypto_two_d.dart';
import '../models/crypto_two_d_live.dart';
import '../models/crypto_two_d_lucky_number.dart';
import '../models/crypto_two_d_section.dart';
import '../repositories/crypto_two_d_repository.dart';
import '../services/crypto_two_d_service.dart';
import 'crypto_two_d_bet_controller.dart';
import 'crypto_two_d_bet_slips_controller.dart';
import 'crypto_two_d_bet_slips_state.dart';
import 'crypto_two_d_controllers.dart';
import 'crypto_two_d_daily_lucky_number_controller.dart';
import 'crypto_two_d_live_controller.dart';
import 'crypto_two_d_lucky_num_history_controller.dart';
import 'crypto_two_d_lucky_num_history_state.dart';
import 'crypto_two_d_section_controller.dart';

final cryptoTwoDServiceProvider =
    Provider((ref) => CryptoTwoDService(ref.read(dioProvider)));

final cryptoTwoDRepositoryProvider = Provider(
    (ref) => CryptoTwoDRepository(ref.read(cryptoTwoDServiceProvider)));

final cryptoTwoDController = StateNotifierProvider.autoDispose<
    CryptoTwoDNotifier, AsyncValue<List<CryptoTwoD>>>(
  (ref) => CryptoTwoDNotifier(
    ref.watch(cryptoTwoDRepositoryProvider),
  ),
);

final selectedCryptoTwoDController = StateNotifierProvider.autoDispose<
    SelectedCryptoTwoDNotifier, List<CryptoTwoD>>(
  (ref) {
    final state = ref.watch(cryptoTwoDController);
    final list =
        state.asData?.value.where((e) => e.isSelected == true).toList() ?? [];
    return SelectedCryptoTwoDNotifier(
      list,
    );
  },
);

final isNotGetWantedAmountController = StateProvider.autoDispose<bool>(
  (ref) {
    final list = ref.watch(selectedCryptoTwoDController);
    final total = list.where((e) => e.isGetExpectedAmount == false).toList();
    return total.isNotEmpty;
  },
);

final cryptoTwoDTotalBetAmountController = StateProvider.autoDispose<double>(
  (ref) {
    final list = ref.watch(selectedCryptoTwoDController);
    final total = list.fold(
        0.0, (previous, current) => previous + (current.betAmount ?? 0));
    return total;
  },
);

final cryptoTwoDSectionController = StateNotifierProvider.autoDispose<
    CryptoTwoDSectionNotifier, AsyncValue<List<CryptoTwoDSection>>>(
  (ref) => CryptoTwoDSectionNotifier(
    ref.watch(cryptoTwoDRepositoryProvider),
  ),
);
final cryptoTwoDBetController =
    StateNotifierProvider<CryptoTwoDBetNotifier, AsyncValue<void>>(
  (ref) => CryptoTwoDBetNotifier(
    ref.watch(cryptoTwoDRepositoryProvider),
  ),
);

final cryptoTwoDBetSlipsController = StateNotifierProvider.autoDispose<
    CryptoTwoDBetSlipsNotifier, CryptoTwoDBetSlipState>(
  (ref) {
    final dateState = ref.watch(dateController);
    return CryptoTwoDBetSlipsNotifier(
      ref,
      ref.watch(cryptoTwoDRepositoryProvider),
      dateState,
    );
  },
);

final cryptoTwoDDailyLuckyNumberController = StateNotifierProvider.autoDispose<
    CryptoTwoDDailyLuckyNumberNotifier,
    AsyncValue<List<CryptoTwoDLuckyNumber>>>(
  (ref) => CryptoTwoDDailyLuckyNumberNotifier(
    ref.watch(cryptoTwoDRepositoryProvider),
  ),
);

final twoDLuckyNumberHistoryController = StateNotifierProvider.autoDispose<
    CryptoTwoDLuckyNumberHistoryNotifier, CryptoTwoDLuckyNumHistoryState>(
  (ref) {
    final dateState = ref.watch(dateController);
    return CryptoTwoDLuckyNumberHistoryNotifier(
      ref,
      ref.watch(cryptoTwoDRepositoryProvider),
      dateState,
    );
  },
);

final cryptoTwoDLuckyNumberHistoryController =
    StateNotifierProvider.autoDispose<CryptoTwoDLuckyNumberHistoryNotifier,
        CryptoTwoDLuckyNumHistoryState>(
  (ref) {
    final dateState = ref.watch(dateController);
    return CryptoTwoDLuckyNumberHistoryNotifier(
      ref,
      ref.watch(cryptoTwoDRepositoryProvider),
      dateState,
    );
  },
);

final cryptoTwoDLiveController = StateNotifierProvider.autoDispose<
    CryptoTwoDLiveNotifier, AsyncValue<CryptoTwoDLive>>(
  (ref) => CryptoTwoDLiveNotifier(),
);
