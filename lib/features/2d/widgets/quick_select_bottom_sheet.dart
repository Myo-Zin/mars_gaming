import 'package:flutter/material.dart';

import '../../crypto2d/widgets/quick_select_widget.dart';

showQuickSelectBottomSheet(BuildContext context) {
  showModalBottomSheet(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    context: context,
    builder: (BuildContext context) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width,
        child: const QuickSelect(),
      );
    },
  );
}
