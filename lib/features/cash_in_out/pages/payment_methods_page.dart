import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/app_color.dart';
import '../provider/providers.dart';
import '../widgets/payment_method_widget.dart';


class PaymentMethodsPage extends ConsumerWidget {
  final String url;
  final String title;
  final bool isCashIn;
  final int? promoId;
  const PaymentMethodsPage({
    required this.url,
    required this.title,
    required this.isCashIn,
    required this.promoId,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paymentController = ref.watch(paymentMethodsController(url));
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(
            color: AppColor.accentColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: paymentController.map(
        loading: (_) => const Center(
          child: CircularProgressIndicator(),
        ),
        data: (data) => PaymentMethodsWidget(
          url: url,
          paymentMethods: data.paymentMethods,
          isCashIn: isCashIn,
          promoid: promoId,
        ),
        error: (error) => Center(
          child: Text(error.message),
        ),
      ),
    );
  }
}
