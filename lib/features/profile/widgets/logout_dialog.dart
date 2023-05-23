import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/providers/providers.dart';

logoutDialog(BuildContext context, WidgetRef ref) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Logout?"),
        content: const Text("Are you sure to logout?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              "Cancel",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          TextButton(
              onPressed: () {
                ref.read(authControllerProvider.notifier).logout();
                Navigator.pop(context);
              },
              child: const Text(
                "Logout",
              ))
        ],
      );
    },
  );
}
