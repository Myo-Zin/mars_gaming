import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mars_gaming/utils/extension.dart';

import '../../../utils/app_color.dart';
import '../../../utils/validator.dart';
import '../models/two_d.dart';
import '../providers/providers.dart';


final textControllerProvider =
    Provider.family.autoDispose<TextEditingController, String>(
  (ref, text) => TextEditingController(text: text),
);

showTwoDEditDialog({
  required BuildContext context,
  required TwoD twoD,
  required GlobalKey<FormState> formKey,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => AlertDialog(
      title: Text("Bet number (${twoD.betNumber})"),
      contentPadding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: TwoDBetEditFormField(
          twoD: twoD,
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
                ref.watch(textControllerProvider(twoD.betAmount.toString()));
            return TextButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  ref
                      .read(selectedTwoDController.notifier)
                      .editAmount(twoD.id!, double.parse(controller.text));
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

class TwoDBetEditFormField extends ConsumerWidget {
  const TwoDBetEditFormField({
    required this.twoD,
    required this.formKey,
    super.key,
  });
  final TwoD twoD;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      key: formKey,
      child: TextFormField(
        controller:
            ref.watch(textControllerProvider(twoD.betAmount.toString())),
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
