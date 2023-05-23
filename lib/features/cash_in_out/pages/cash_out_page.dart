import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mars_gaming/utils/async_value_ui.dart';
import 'package:mars_gaming/utils/extension.dart';
import '../../../utils/app_theme.dart';
import '../../../utils/url_constants.dart';
import '../../../utils/validator.dart';
import '../../profile/providers/providers.dart';
import '../model/cash_out_form.dart';
import '../provider/providers.dart';
import '../widgets/amount_grid.dart';

class CashOutPage extends ConsumerStatefulWidget {
  final String title;
  final String image;
  final int paymentId;

  const CashOutPage({
    super.key,
    required this.title,
    required this.image,
    required this.paymentId,
  });

  @override
  ConsumerState<CashOutPage> createState() => _CashFormPageState();
}

class _CashFormPageState extends ConsumerState<CashOutPage> {
  late TextEditingController nameTextController;
  late TextEditingController userPhoneNumberController;
  late TextEditingController amountTextController;
  late TextEditingController passwordTextController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameTextController = TextEditingController();
    userPhoneNumberController = TextEditingController();
    amountTextController = TextEditingController();
    passwordTextController = TextEditingController();
  }

  @override
  void dispose() {
    nameTextController.dispose();
    userPhoneNumberController.dispose();
    amountTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(profileControllerProvider);
    final cashInState = ref.watch(cashOutNotifierProvider);
    ref.listen(cashOutNotifierProvider, (previous, next) {
      next.showSnackBarOnError(context);
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
                              UrlConst.imagePrefix + widget.image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      validator: (value) => Validator.valueExists(value),
                      controller: nameTextController,
                      decoration: AppTheme.authTextFieldDecoration.copyWith(
                        label: Text(AppLocalizations.of(context).holdername),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      validator: (value) => Validator.phoneValidate(value),
                      controller: userPhoneNumberController,
                      keyboardType: TextInputType.phone,
                      decoration: AppTheme.authTextFieldDecoration.copyWith(
                        label: Text(AppLocalizations.of(context).phone),
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
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      validator: (value) => Validator.valueExists(value),
                      controller: passwordTextController,
                      obscureText: true,
                      decoration: AppTheme.authTextFieldDecoration.copyWith(
                        label: Text(AppLocalizations.of(context).password),
                      ),
                    ),
                    const SizedBox(height: 20),
                    AmountGrid(amountTextController),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 30,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: cashInState.isLoading
                              ? null
                              : () {
                                  if (_formKey.currentState?.validate() ==
                                      true) {
                                    profile.maybeMap(
                                        data: (value) {
                                          CashOutForm form = CashOutForm(
                                            userid: value.profileData.id!,
                                            paymentid: widget.paymentId,
                                            accountname:
                                                nameTextController.text,
                                            amount: int.parse(
                                                amountTextController.text),
                                            userphone:
                                                userPhoneNumberController.text,
                                          );
                                          ref
                                              .read(cashOutNotifierProvider
                                                  .notifier)
                                              .cashOut(
                                                  form,
                                                  value.profileData.token!,
                                                  passwordTextController.text)
                                              .then((value) {
                                            if (value) {
                                              context.showSuccessSnackbar(
                                                  "Cash Out Success");
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                            }
                                          });
                                        },
                                        orElse: () {});
                                  }
                                },
                          child: cashInState.isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.black)
                              : Text(AppLocalizations.of(context).cashOut),
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
