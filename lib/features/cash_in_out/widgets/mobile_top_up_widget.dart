import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mars_gaming/utils/async_value_ui.dart';
import 'package:mars_gaming/utils/extension.dart';

import '../../../utils/app_theme.dart';
import '../../../utils/url_constants.dart';
import '../../../utils/validator.dart';
import '../../profile/providers/providers.dart';
import '../model/cash_in_form.dart';
import '../provider/providers.dart';
import 'amount_grid_2.dart';

class CashInPageMobileWidget extends ConsumerStatefulWidget {
  final String? title;
  final String? image;
  final int paymentId;
  final int? promoId;
  final String fees;

  const CashInPageMobileWidget({
    super.key,
    required this.title,
    required this.image,
    required this.paymentId,
    required this.fees,
    required this.promoId,
  });

  @override
  ConsumerState<CashInPageMobileWidget> createState() => _CashFormPageState();
}

class _CashFormPageState extends ConsumerState<CashInPageMobileWidget> {
  late TextEditingController amountTextController;
  late TextEditingController transactionIdTextController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    amountTextController = TextEditingController();
    transactionIdTextController = TextEditingController();
  }

  @override
  void dispose() {
    amountTextController.dispose();
    transactionIdTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(profileControllerProvider);
    final cashInState = ref.watch(cashInNotifierProvider);
    // final holderPhone = ref.watch(holderPhoneProvider);
    ref.listen(cashInNotifierProvider, (previous, next) {
      next.showSnackBarOnError(context);
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? ""),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.center,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 100,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                              UrlConst.imagePrefix + widget.image!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const SizedBox(height: 20),
                    const SizedBox(height: 20),
                    TextFormField(
                      validator: (value) => Validator.valueExists(value),
                      controller: transactionIdTextController,
                      keyboardType: TextInputType.number,
                      decoration: AppTheme.authTextFieldDecoration.copyWith(
                        label: const Text("Voucher Code"),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      validator: (value) => Validator.amountValidate(value),
                      controller: amountTextController,
                      keyboardType: TextInputType.number,
                      decoration: AppTheme.authTextFieldDecoration.copyWith(
                        label: Text(AppLocalizations.of(context).amount),
                      ),
                      enabled: false,
                    ),
                    const SizedBox(height: 20),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Choose Amount (Fee: ${widget.fees}%)")),
                    AmountGridMobile(amountTextController),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 30,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() == true) {
                              // if (holderPhone == null) {
                              //   context.showErrorSnackbar(
                              //       AppLocalizations.of(context)
                              //           .pleaseEnterPhNo);
                              //   return;
                              // }
                              profile.maybeMap(
                                data: (value) {
                                  CashInForm form = CashInForm(
                                    userid: value.profileData.id!,
                                    paymentid: widget.paymentId,
                                    accountname: "",
                                    transactionid:
                                        transactionIdTextController.text,
                                    amount:
                                        int.parse(amountTextController.text),
                                    holderPhone: "",
                                    promoid: widget.promoId,
                                    userphone: "",
                                  );
                                  ref
                                      .read(cashInNotifierProvider.notifier)
                                      .mobileToUp(
                                          form, value.profileData.token!)
                                      .then((value) {
                                    if (value) {
                                      context.showSuccessSnackbar(
                                        "Cash In Success",
                                      );
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    }
                                  });
                                },
                                orElse: () {},
                              );
                            }
                          },
                          child: cashInState.isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.black)
                              : Text(AppLocalizations.of(context).cashIn),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

final holderPhoneProvider = StateProvider.autoDispose<int?>((ref) => null);
