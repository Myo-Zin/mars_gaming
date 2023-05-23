import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final levelImagePickControllerProvider =
    StateNotifierProvider<LevelImageController, File?>(
  (ref) => LevelImageController(),
);

class LevelImageController extends StateNotifier<File?> {
  LevelImageController() : super(null);

  Future pickImageFromGallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      state = imageTemp;
    } on PlatformException catch (e) {
      log('Failed to pick image: $e');
    }
  }

  Future pickImageCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemp = File(image.path);
      state = imageTemp;
    } on PlatformException catch (e) {
      log('Failed to pick image: $e');
    }
  }
}
