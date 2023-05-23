import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension AsyncValueUI on AsyncValue {
  void showSnackBarOnError(BuildContext context) {
    if (!isRefreshing && hasError) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.error, color: Colors.red),
                const SizedBox(width: 20),
                Flexible(
                  child: Text(
                    error.toString(),
                  ),
                ),
              ],
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );
    }
  }
}
