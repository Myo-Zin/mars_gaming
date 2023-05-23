import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mars_gaming/features/cash_in_out/provider/payment_method_controller.dart';

import '../../../core/providers/dio_provider.dart';
import '../repository/payment_repository.dart';
import '../services/payment_service.dart';
import 'cash_in_controller.dart';
import 'cash_out_controller.dart';
import 'payment_state.dart';



final paymentServiceProvider =
    Provider((ref) => PaymentService(ref.read(dioProvider)));

final paymentRepositoryProvider = Provider(
  (ref) => PaymentRepository(ref.read(paymentServiceProvider)),
);

final paymentMethodsController = StateNotifierProvider.family<
    PaymentMethodsNotifier, PaymentMethodsState, String>((ref, url) {
  return PaymentMethodsNotifier(
    url,
    ref.read(paymentRepositoryProvider),
  );
});

final cashInNotifierProvider =
    StateNotifierProvider<CashInNotifier, AsyncValue<void>>(
  (ref) => CashInNotifier(
    ref.read(paymentRepositoryProvider),
  ),
);

final cashOutNotifierProvider =
    StateNotifierProvider<CashOutNotifier, AsyncValue<void>>(
  (ref) => CashOutNotifier(
    ref.read(paymentRepositoryProvider),
  ),
);
