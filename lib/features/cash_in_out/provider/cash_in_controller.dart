import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/cash_in_form.dart';
import '../repository/payment_repository.dart';


class CashInNotifier extends StateNotifier<AsyncValue<void>> {
  CashInNotifier(
    this._repository,
  ) : super(const AsyncData(null));

  final PaymentRepository _repository;

  Future<bool> cashIn(CashInForm cashInForm, String token) async {
    state = const AsyncLoading();
    final result = await _repository.cashIn(cashInForm, token);

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
  Future<bool> mobileToUp(CashInForm cashInForm, String token) async {
    state = const AsyncLoading();
    final result = await _repository.mobileToUp(cashInForm, token);

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
