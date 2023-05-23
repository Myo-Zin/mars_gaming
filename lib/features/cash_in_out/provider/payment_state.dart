import 'package:freezed_annotation/freezed_annotation.dart';


import '../model/payment_methods.dart';

part 'payment_state.freezed.dart';

@freezed
class PaymentMethodsState with _$PaymentMethodsState{
  const factory PaymentMethodsState.loading() = _Loading;
  const factory PaymentMethodsState.data(PaymentMethods paymentMethods) = _Data;
  const factory PaymentMethodsState.error(String message) = _Error;
}
