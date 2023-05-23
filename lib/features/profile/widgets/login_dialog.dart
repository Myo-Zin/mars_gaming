import 'package:flutter/material.dart';

import '../../../utils/route.dart';
import '../../auth/pages/login_page.dart';


loginDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Notice"),
        content: const Text("You need to login."),
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
                Navigator.pop(context);
                goto(context,
                    page: const LoginPage(
                      isfromDialog: true,
                    ));
              },
              child: const Text(
                "Login",
              ))
        ],
      );
    },
  );
}
