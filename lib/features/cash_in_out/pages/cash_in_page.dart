import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mars_gaming/utils/async_value_ui.dart';
import 'package:mars_gaming/utils/extension.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_theme.dart';
import '../../../utils/url_constants.dart';
import '../../../utils/validator.dart';
import '../../profile/providers/providers.dart';
import '../model/cash_in_form.dart';
import '../model/payment_methods.dart';
import '../provider/providers.dart';
import '../widgets/amount_grid.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CashInPage extends ConsumerStatefulWidget {
  final String? title;
  final String? image;
  final int paymentId;
  final int? promoId;
  final List<PaymentAccount> accounts;

  const CashInPage({
    super.key,
    required this.title,
    required this.image,
    required this.paymentId,
    required this.accounts,
    required this.promoId,
  });

  @override
  ConsumerState<CashInPage> createState() => _CashFormPageState();
}

class _CashFormPageState extends ConsumerState<CashInPage> {
  late TextEditingController nameTextController;
  late TextEditingController userPhoneTextController;
  late TextEditingController amountTextController;
  late TextEditingController transactionIdTextController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameTextController = TextEditingController();
    amountTextController = TextEditingController();
    transactionIdTextController = TextEditingController();
    userPhoneTextController = TextEditingController();
  }

  @override
  void dispose() {
    nameTextController.dispose();
    userPhoneTextController = TextEditingController();
    amountTextController.dispose();
    transactionIdTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(profileControllerProvider);
    final cashInState = ref.watch(cashInNotifierProvider);
    final holderPhone = ref.watch(holderPhoneProvider);
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
                              widget.image!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      validator: (value) => Validator.valueExists(value),
                      controller: nameTextController,
                      decoration: AppTheme.authTextFieldDecoration.copyWith(
                        label: Text(
                            AppLocalizations.of(context).accountHolderName),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      validator: (value) => Validator.phoneValidate(value),
                      controller: userPhoneTextController,
                      keyboardType: TextInputType.phone,
                      decoration: AppTheme.authTextFieldDecoration.copyWith(
                        label: Text(AppLocalizations.of(context).phone),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      validator: (value) => Validator.valueExists(value),
                      controller: transactionIdTextController,
                      keyboardType: TextInputType.number,
                      decoration: AppTheme.authTextFieldDecoration.copyWith(
                        label: Text(
                            "${AppLocalizations.of(context).transationID}${AppLocalizations.of(context).lastDigit}"),
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
                    AmountGrid(amountTextController),
                    _PaymentAccount(widget.accounts),
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
                              if (holderPhone == null) {
                                context.showErrorSnackbar(
                                    "Please Select Phone Number");
                                return;
                              }
                              profile.maybeMap(
                                data: (value) {
                                  CashInForm form = CashInForm(
                                    userid: value.profileData.id!,
                                    paymentid: widget.paymentId,
                                    accountname: nameTextController.text,
                                    transactionid:
                                    transactionIdTextController.text,
                                    amount: int.parse(
                                        amountTextController.text),
                                    holderPhone:holderPhone,
                                    userphone:
                                    userPhoneTextController.text,
                                    promoid: widget.promoId,
                                  );
                                  ref
                                      .read(
                                      cashInNotifierProvider.notifier)
                                      .cashIn(
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

final holderPhoneProvider = StateProvider.autoDispose<String?>((ref) => null);

class _PaymentAccount extends StatelessWidget {
  final List<PaymentAccount> accounts;

  const _PaymentAccount(this.accounts);

  @override
  Widget build(BuildContext context) {
    if (accounts.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 30),
        Text(
          AppLocalizations.of(context).pleaseTransferToFollowingNo,
          style: AppTextStyle.yellowMedium,
        ),
        const SizedBox(height: 20),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: accounts.length,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            mainAxisExtent: 90,
          ),
          itemBuilder: (context, index) {
            return Consumer(
              builder: (context, ref, child) {
                final holderPhone = ref.watch(holderPhoneProvider);
                final currentIndex =
                    holderPhone == accounts[index].accountNumber!;
                return GestureDetector(
                  onTap: () {
                    ref.read(holderPhoneProvider.notifier).state =
                    accounts[index].accountNumber!;
                  },
                  child: Container(
                    decoration: AppTheme.containerDecoration.copyWith(
                      color: currentIndex
                          ? AppColor.accentColor
                          : AppColor.secondColor,
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                accounts[index].accountName.toString(),
                                style: AppTextStyle.yellowMedium.copyWith(
                                  color: currentIndex
                                      ? AppColor.greyTextColor
                                      : AppColor.accentColor,
                                ),
                              ),
                              Text(
                                accounts[index].accountNumber.toString(),
                                style: TextStyle(
                                  color: currentIndex ? Colors.black : Colors.white,
                                ),
                              ),

                            ],
                          ),
                        ),
                        Positioned(right: 1, child: Icon(currentIndex?Icons.check_circle: null,color: Colors.green,size: 20,))
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}

