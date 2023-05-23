import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mars_gaming/features/3d/providers/seleted_three_d_controller.dart';
import 'package:mars_gaming/features/3d/providers/three_d_bet_controller.dart';
import 'package:mars_gaming/features/3d/providers/three_d_bet_slip_controller.dart';
import 'package:mars_gaming/features/3d/providers/three_d_bet_slips_state.dart';
import 'package:mars_gaming/features/3d/providers/three_d_controllers.dart';
import 'package:mars_gaming/features/3d/providers/three_d_lucky_number_controller.dart';
import 'package:mars_gaming/features/3d/providers/three_d_lucky_number_history_controller.dart';
import 'package:mars_gaming/features/3d/providers/three_d_lucky_number_state.dart';
import 'package:mars_gaming/features/3d/providers/three_d_section_controller.dart';
import '../../../core/providers/date_controller.dart';
import '../../../core/providers/dio_provider.dart';
import '../models/Three_d_lucky_number.dart';
import '../models/three_d.dart';
import '../repositories/three_d_repository.dart';
import '../services/three_d_service.dart';

final threeDServiceProvider =
    Provider((ref) => ThreeDService(ref.read(dioProvider)));

final threeDRepositoryProvider =
    Provider((ref) => ThreeDRepository(ref.read(threeDServiceProvider)));

final threeDController =
    StateNotifierProvider.autoDispose<ThreeDNotifier, AsyncValue<List<ThreeD>>>(
  (ref) => ThreeDNotifier(
    ref.watch(threeDRepositoryProvider),
  ),
);

final selectedThreeDController =
    StateNotifierProvider.autoDispose<SelectedThreeDNotifier, List<ThreeD>>(
  (ref) {
    final state = ref.watch(threeDController);
    final list =
        state.asData?.value.where((e) => e.isSelected == true).toList() ?? [];
    return SelectedThreeDNotifier(
      list,
    );
  },
);

final threeDTotalBetAmountController = StateProvider.autoDispose<double>(
  (ref) {
    final list = ref.watch(selectedThreeDController);
    final total = list.fold(
        0.0, (previous, current) => previous + (current.betAmount ?? 0));
    return total;
  },
);

final threeDIsNotGetWantedAmountController = StateProvider.autoDispose<bool>(
  (ref) {
    final list = ref.watch(selectedThreeDController);
    final total = list.where((e) => e.isGetExpectedAmount == false).toList();
    return total.isNotEmpty;
  },
);

final threeDBetController =
    StateNotifierProvider<ThreeDBetNotifier, AsyncValue<void>>(
  (ref) => ThreeDBetNotifier(
    ref.watch(threeDRepositoryProvider),
  ),
);

final threeDBetSlipsController = StateNotifierProvider.autoDispose<
    ThreeDBetSlipsNotifier, ThreeDBetSlipState>(
  (ref) {
    final dateState = ref.watch(dateController);
    return ThreeDBetSlipsNotifier(
      ref,
      ref.watch(threeDRepositoryProvider),
      dateState,
    );
  },
);

final threeDDailyLuckyNumberController = StateNotifierProvider.autoDispose<
    ThreeDLuckyNumberNotifier, AsyncValue<List<ThreeDLuckyNumber>>>(
  (ref) => ThreeDLuckyNumberNotifier(
    ref.watch(threeDRepositoryProvider),
  ),
);
final threeDSectionController =
    StateNotifierProvider<ThreeDSectionNotifier, AsyncValue<void>>(
  (ref) => ThreeDSectionNotifier(
    ref.watch(threeDRepositoryProvider),
  ),
);

final threeDLuckyNumberHistoryController = StateNotifierProvider.autoDispose<
    ThreeDLuckyNumberHistoryNotifier, ThreeDLuckyNumHistoryState>(
  (ref) {
    final dateState = ref.watch(dateController);
    return ThreeDLuckyNumberHistoryNotifier(
      ref,
      ref.watch(threeDRepositoryProvider),
      dateState,
    );
  },
);
