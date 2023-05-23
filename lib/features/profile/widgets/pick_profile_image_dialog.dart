import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/app_color.dart';
import '../providers/level_image_controller.dart';
import '../providers/profile_image_controller.dart';
import 'listile_row.dart';


pickProfileImageDialog(BuildContext context, WidgetRef ref, String from) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(17.0),
    ),
    backgroundColor: AppColor.secondColor,
    builder: (BuildContext context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 20),
          ListTileRow(
            icon: Icons.camera_alt,
            title: "Camera",
            subtitle: "Take image from camera",
            callback: () {
              if (from == "profile") {
                ref
                    .read(profileImagePickControllerProvider.notifier)
                    .pickImageCamera();
              } else {
                ref
                    .read(levelImagePickControllerProvider.notifier)
                    .pickImageCamera();
              }
              Navigator.pop(context);
            },
          ),
          ListTileRow(
            icon: Icons.image,
            title: "Gallery",
            subtitle: "Pick image from gallery",
            callback: () {
              if (from == "profile") {
                ref
                    .read(profileImagePickControllerProvider.notifier)
                    .pickImageFromGallery();
              } else {
                ref
                    .read(levelImagePickControllerProvider.notifier)
                    .pickImageFromGallery();
              }
              Navigator.pop(context);
            },
          ),
          const SizedBox(height: 20),
        ],
      );
    },
  );
}
