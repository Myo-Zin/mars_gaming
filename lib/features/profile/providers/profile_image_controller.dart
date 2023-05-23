import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final profileImagePickControllerProvider =
    StateNotifierProvider<ImageController, File?>(
  (ref) => ImageController(),
);

class ImageController extends StateNotifier<File?> {
  ImageController() : super(null);

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
