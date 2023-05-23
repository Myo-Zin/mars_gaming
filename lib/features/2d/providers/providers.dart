import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mars_gaming/features/2d/providers/selected_two_d_controller.dart';
import 'package:mars_gaming/features/2d/providers/thai_two_d_live_controller.dart';
import 'package:mars_gaming/features/2d/providers/two_d_bet_controller.dart';
import 'package:mars_gaming/features/2d/providers/two_d_bet_slips_controller.dart';
import 'package:mars_gaming/features/2d/providers/two_d_controllers.dart';
import 'package:mars_gaming/features/2d/providers/two_d_daily_lucky_number_controller.dart';
import 'package:mars_gaming/features/2d/providers/two_d_lucky_num_history_controller.dart';
import 'package:mars_gaming/features/2d/providers/two_d_lucky_num_history_state.dart';
import 'package:mars_gaming/features/2d/providers/two_d_section_controller.dart';
import '../../../core/providers/date_controller.dart';
import '../../../core/providers/dio_provider.dart';
import '../models/thai_two_d_live.dart';
import '../models/two_d.dart';
import '../models/two_d_lucky_number.dart';
import '../models/two_d_section.dart';
import '../repositories/two_d_repository.dart';
import '../services/two_d_service.dart';
import 'two_d_bet_slips_state.dart';

final twoDServiceProvider =
    Provider((ref) => TwoDService(ref.read(dioProvider)));

final twoDRepositoryProvider =
    Provider((ref) => TwoDRepository(ref.read(twoDServiceProvider)));

final twoDController =
    StateNotifierProvider.autoDispose<TwoDNotifier, AsyncValue<List<TwoD>>>(
  (ref) => TwoDNotifier(
    ref.watch(twoDRepositoryProvider),
  ),
);

final selectedTwoDController =
    StateNotifierProvider.autoDispose<SelectedTwoDNotifier, List<TwoD>>(
  (ref) {
    final state = ref.watch(twoDController);
    final list =
        state.asData?.value.where((e) => e.isSelected == true).toList() ?? [];
    return SelectedTwoDNotifier(
      list,
    );
  },
);

final isNotGetWantedAmountController = StateProvider.autoDispose<bool>(
  (ref) {
    final list = ref.watch(selectedTwoDController);
    final total = list.where((e) => e.isGetExpectedAmount == false).toList();
    return total.isNotEmpty;
  },
);

final twoDTotalBetAmountController = StateProvider.autoDispose<double>(
  (ref) {
    final list = ref.watch(selectedTwoDController);
    final total = list.fold(
        0.0, (previous, current) => previous + (current.betAmount ?? 0));
    return total;
  },
);

final twoDSectionController = StateNotifierProvider.autoDispose<
    TwoDSectionNotifier, AsyncValue<List<TwoDSection>>>(
  (ref) => TwoDSectionNotifier(
    ref.watch(twoDRepositoryProvider),
  ),
);
final twoDBetController =
    StateNotifierProvider<TwoDBetNotifier, AsyncValue<void>>(
  (ref) => TwoDBetNotifier(
    ref.watch(twoDRepositoryProvider),
  ),
);

final twoDBetSlipsController =
    StateNotifierProvider.autoDispose<TwoDBetSlipsNotifier, TwoDBetSlipState>(
  (ref) {
    final dateState = ref.watch(dateController);
    return TwoDBetSlipsNotifier(
      ref,
      ref.watch(twoDRepositoryProvider),
      dateState,
    );
  },
);

final twoDDailyLuckyNumberController = StateNotifierProvider.autoDispose<
    TwoDDailyLuckyNumberNotifier, AsyncValue<List<TwoDLuckyNumber>>>(
  (ref) => TwoDDailyLuckyNumberNotifier(
    ref.watch(twoDRepositoryProvider),
  ),
);
final thaiTwoDLiveController = StateNotifierProvider.autoDispose<
    ThaiTwoDLiveNotifier, AsyncValue<ThaiTwoDLive>>(
  (ref) => ThaiTwoDLiveNotifier(
    ref.watch(twoDRepositoryProvider),
  ),
);

final twoDLuckyNumberHistoryController =  StateNotifierProvider.autoDispose<
    TwoDLuckyNumberHistoryNotifier,TwoDLuckyNumHistoryState>(
      (ref) {
    final dateState = ref.watch(dateController);
    return TwoDLuckyNumberHistoryNotifier(
      ref,
      ref.watch(twoDRepositoryProvider),
      dateState,
    );
  },
);