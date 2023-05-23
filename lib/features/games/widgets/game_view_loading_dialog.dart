import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

showGameViewLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Consumer(
        builder: (context, ref, _) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );
    },
  );
}
