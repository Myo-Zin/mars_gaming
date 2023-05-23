import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../home/models/app_update_response.dart';

showUpdateDialog(
  BuildContext context,
  AppUpdateData data, {
  VoidCallback? goto,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return WillPopScope(
        onWillPop: () {
          return Future.value(false);
        },
        child: AlertDialog(
          title: const Text("Update"),
          content: Text(
            data.description ??
                "The new version is available. Please update to get the best experience.",
          ),
          actions: [
            if (data.forceUpdate == 0)
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  goto?.call();
                },
                child: const Text("Later"),
              ),
            ElevatedButton(
              onPressed: () async {
                if (data.downloadLink != null) {
                  if (await canLaunchUrl(Uri.parse(data.downloadLink!))) {
                    launchUrl(
                      Uri.parse(data.downloadLink!),
                      mode: LaunchMode.externalApplication,
                    );
                  }
                }
              },
              child: const Text("Update"),
            ),
          ],
        ),
      );
    },
  );
}
