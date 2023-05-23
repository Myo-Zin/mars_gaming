import 'package:flutter/material.dart';

import '../../../utils/app_color.dart';

class QuickSelectButton extends StatelessWidget {
  const QuickSelectButton({
    Key? key,
    required this.label,
    this.onTap,
  }) : super(key: key);
  final String label;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.amber,
        padding: const EdgeInsets.all(5),
        backgroundColor: Colors.black,
      ),
      child: FittedBox(
        child: Text(
          label,
          style: TextStyle(color: AppColor.accentColor),
        ),
      ),
    );
  }
}
