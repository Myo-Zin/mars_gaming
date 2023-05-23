import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mars_gaming/utils/extension.dart';
import '../../../utils/app_color.dart';
import '../../../utils/validator.dart';
import '../models/three_d.dart';
import '../providers/providers.dart';

final textControllerProvider =
    Provider.family.autoDispose<TextEditingController, String>(
  (ref, text) => TextEditingController(text: text),
);

showThreeDEditDialog({
  required BuildContext context,
  required ThreeD threeD,
  required GlobalKey<FormState> formKey,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => AlertDialog(
      title: Text("Bet number (${threeD.betNumber})"),
      contentPadding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: TwoDBetEditFormField(
          threeD: threeD,
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
                ref.watch(textControllerProvider(threeD.betAmount.toString()));
            return TextButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  ref
                      .read(selectedThreeDController.notifier)
                      .editAmount(threeD.id!, double.parse(controller.text));
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
    required this.threeD,
    required this.formKey,
    super.key,
  });
  final ThreeD threeD;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      key: formKey,
      child: TextFormField(
        controller:
            ref.watch(textControllerProvider(threeD.betAmount.toString())),
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
