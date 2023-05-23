import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/app_color.dart';


class DatePickerTextField extends ConsumerWidget {
  const DatePickerTextField({
    super.key,
    required this.date,
  });
  final String date;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.accentColor),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(date),
      ),
    );
  }
}
