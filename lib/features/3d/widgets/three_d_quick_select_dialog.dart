import 'package:flutter/material.dart';

import 'three_d_quick_select_widget.dart';


showThreeDQuickSelectDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: const QuickSelectThreeD(),
      );
      
    },
  );
}
