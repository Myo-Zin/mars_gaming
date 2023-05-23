import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/cash_out_form.dart';
import '../repository/payment_repository.dart';


class CashOutNotifier extends StateNotifier<AsyncValue<void>> {
  CashOutNotifier(
    this._repository,
  ) : super(const AsyncData(null));

  final PaymentRepository _repository;

  Future<bool> cashOut(CashOutForm cashOutForm, String token,String password) async {
    state = const AsyncLoading();
    final result = await _repository.cashOut(cashOutForm, token,password);

    return await result.fold(
      (l) {
        if (mounted) {
          state = AsyncError(l.message, StackTrace.empty);
        }

        return false;
      },
      (r) {
        if (mounted) {
          state = const AsyncData(null);
        }
        return true;
      },
    );
  }
}
