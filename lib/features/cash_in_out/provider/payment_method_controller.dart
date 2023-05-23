import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../repository/payment_repository.dart';
import 'payment_state.dart';

class PaymentMethodsNotifier extends StateNotifier<PaymentMethodsState> {
  final String url;
  final PaymentRepository _paymentRepository;

  PaymentMethodsNotifier(
    this.url,
    this._paymentRepository,
  ) : super(const PaymentMethodsState.loading()) {
    getPaymentMethods();
  }

  getPaymentMethods() async {
    final result = await _paymentRepository.getPaymentMethods(url);
    if (mounted) {
      state = result.fold(
        (l) => PaymentMethodsState.error(l.message),
        (r) => PaymentMethodsState.data(r),
      );
    }
  }
}
