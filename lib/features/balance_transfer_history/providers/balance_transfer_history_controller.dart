import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/date_state.dart';
import '../../../utils/failure.dart';
import '../../../utils/url_constants.dart';
import '../models/balance_transfer_history_response.dart';
import '../repositories/balance_transfer_history_repository.dart';
import 'balance_transfer_history_state.dart';




enum BalanceTransferType { gameToMain, mainToGame }

class BalanceTransferHistoryNotifier
    extends StateNotifier<BalanceTransferHistoryState> {
  final DateState dateState;
  final BalanceTransferType type;
  final BalanceTransferHistoryRepository repository;

  BalanceTransferHistoryNotifier({
    required this.dateState,
    required this.repository,
    required this.type,
  }) : super(const BalanceTransferHistoryState.empty()) {
    if (!dateState.isEmpty) {
      getCashInHistory();
    }
  }

  Future<void> getCashInHistory() async {
    state = const BalanceTransferHistoryState.loading();

    final url = type == BalanceTransferType.gameToMain
        ? UrlConst.gameToMainTransferHistoryUrl(
            startDate: dateState.startDate!, endDate: dateState.endDate!)
        : UrlConst.mainToGameTransferHistoryUrl(
            startDate: dateState.startDate!, endDate: dateState.endDate!);

    final Either<Failure, List<BalanceTransferHistory>> result =
        await repository.getBalanceTransferHistory(
      token: dateState.token!,
      url: url,
    );
    if (mounted) {
      state = result.fold(
        (failture) => BalanceTransferHistoryState.error(failture.message),
        (list) => BalanceTransferHistoryState.data(list),
      );
    }
  }
}
