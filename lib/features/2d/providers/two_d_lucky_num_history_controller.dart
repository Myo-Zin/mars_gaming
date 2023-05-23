

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mars_gaming/features/2d/providers/two_d_lucky_num_history_state.dart';
import '../../../core/providers/date_state.dart';
import '../../../utils/failure.dart';
import '../../auth/providers/providers.dart';
import '../repositories/two_d_repository.dart';

class TwoDLuckyNumberHistoryNotifier
    extends StateNotifier<TwoDLuckyNumHistoryState> {
  final Ref ref;
  final TwoDRepository twoDRepository;
  final DateState dateState;

  TwoDLuckyNumberHistoryNotifier(
      this.ref,
      this.twoDRepository,
      this.dateState,
      ) : super(const TwoDLuckyNumHistoryState.empty()) {
    if (!dateState.isEmpty) {
      getTwoDLuckyNumberHistory(dateState);
    }
  }

  Future<void> getTwoDLuckyNumberHistory(DateState ds) async {
    state = const TwoDLuckyNumHistoryState.loading();
    final result = await twoDRepository.getTwoLuckyNumHistory(ds);
    if (mounted) {
      result.fold(
            (failure) {
          if (failure.reason == FailureReason.authError) {
            ref.read(authControllerProvider.notifier).logout();
          }
          if (mounted) {
            state = TwoDLuckyNumHistoryState.error(failure.message);
          }
        },
            (list) {
          state = TwoDLuckyNumHistoryState.data(list);
        },
      );
    }
  }
}
