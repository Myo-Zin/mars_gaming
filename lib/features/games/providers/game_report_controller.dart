import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../../core/providers/date_state.dart';

import '../../../utils/failure.dart';
import '../../auth/providers/providers.dart';
import '../repositories/games_repository.dart';
import 'game_report_state.dart';

class GameReportNotifier extends StateNotifier<GameReportState> {
  final Ref ref;
  final DateState dateState;
  final GameRepository repository;

  GameReportNotifier(
    this.ref,
    this.repository,
    this.dateState,
  ) : super(const GameReportState.empty()) {
    if (!dateState.isEmpty) {
      getGameReport(dateState);
    }
  }

  Future<void> getGameReport(DateState ds) async {
    state = const GameReportState.loading();
    final result = await repository.getGameReports(ds);
    if (mounted) {
      result.fold(
        (failture) {
          if (failture.reason == FailureReason.authError) {
           ref.read(authControllerProvider.notifier).logout();
          }
          if (mounted) {
            state = GameReportState.error(failture.message);
          }
        },
        (list) {
          state = GameReportState.data(list);
        },
      );
    }
  }
}
