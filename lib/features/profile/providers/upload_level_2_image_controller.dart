import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/profile_repository.dart';

class UploadLevel2ImageNotifier extends StateNotifier<AsyncValue<void>> {
  final ProfileRepository _profileRepository;

  UploadLevel2ImageNotifier(this._profileRepository)
      : super(const AsyncData(null));

  Future<bool> uploadLevel2Image({required String token, File? file}) async {
    state = const AsyncLoading();
    final result =
        await _profileRepository.uploadLeve2Image(token: token, file: file);

    return result.fold(
      (l) {
        if (mounted) {
          state = AsyncError(l.message, StackTrace.empty);

        }

        return false;
      },
      (r) {
        if (mounted) {
          state = const AsyncData(null);
        }
        return true;
      },
    );
  }
}
