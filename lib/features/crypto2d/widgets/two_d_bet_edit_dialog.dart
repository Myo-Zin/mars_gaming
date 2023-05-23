import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mars_gaming/utils/extension.dart';


import '../../../utils/app_color.dart';
import '../../../utils/validator.dart';
import '../models/crypto_two_d.dart';
import '../providers/providers.dart';


final textControllerProvider =
    Provider.family.autoDispose<TextEditingController, String>(
  (ref, text) => TextEditingController(text: text),
);

showCryptoTwoDEditDialog({
  required BuildContext context,
  required CryptoTwoD cryptoTwoD,
  required GlobalKey<FormState> formKey,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => AlertDialog(
      title: Text("Bet number (${cryptoTwoD.betNumber})"),
      contentPadding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: CryptoTwoDBetEditFormField(
          cryptoTwoD: cryptoTwoD,
          formKey: formKey,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            "CANCEL".hardCoded,
            style: TextStyle(color: Colors.grey.shade500),
          ),
        ),
        Consumer(
          builder: (context, ref, child) {
            final controller =
                ref.watch(textControllerProvider(cryptoTwoD.betAmount.toString()));
            return TextButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  ref
                      .read(selectedCryptoTwoDController.notifier)
                      .editAmount(cryptoTwoD.id!, double.parse(controller.text));
                  Navigator.of(context).pop();
                }
              },
              child: Text(
                "CONFIRM".hardCoded,
                style: const TextStyle(color: Colors.blue),
              ),
            );
          },
        ),
      ],
    ),
  );
}

class CryptoTwoDBetEditFormField extends ConsumerWidget {
  const CryptoTwoDBetEditFormField({
    required this.cryptoTwoD,
    required this.formKey,
    super.key,
  });
  final CryptoTwoD cryptoTwoD;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      key: formKey,
      child: TextFormField(
        controller:
            ref.watch(textControllerProvider(cryptoTwoD.betAmount.toString())),
        keyboardType: TextInputType.number,
        style: const TextStyle(color: Colors.white),
        autofocus: false,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
          hintText: "Edit Amount".hardCoded,
          prefixIcon: Icon(
            Icons.paid,
            size: 23,
            color: AppColor.accentColor,
          ),
        ),
        validator: (value) => Validator.amountValidate(value),
      ),
    );
  }
}
