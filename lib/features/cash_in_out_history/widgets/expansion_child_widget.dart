import 'package:flutter/material.dart';

import '../../../utils/app_color.dart';



class ExpansionChildWidget extends StatelessWidget {
  const ExpansionChildWidget({
    Key? key,
    required this.label,
    required this.content,
  }) : super(key: key);

  final String label;
  final String? content;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 3.0),
          child: Text(
            "$label:",
            style: TextStyle(color: AppColor.greyTextColor),
          ),
        ),
        const SizedBox(width: 10),
        Text(content ?? "_"),
      ],
    );
  }
}
