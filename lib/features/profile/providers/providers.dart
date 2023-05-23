import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mars_gaming/features/profile/providers/upload_level_2_image_controller.dart';


import '../../../core/providers/dio_provider.dart';
import '../repositories/profile_repository.dart';
import '../service/profile_service.dart';
import 'profile_controller.dart';
import 'profile_state.dart';
import 'profile_update_controller.dart';


final profileServiceProvider =
    Provider((ref) => ProfileService(ref.read(dioProvider)));

final profileRepositoryProvider =
    Provider((ref) => ProfileRepository(ref.read(profileServiceProvider)));

final profileControllerProvider =
    StateNotifierProvider<ProfileNotifier, ProfileState>((ref) {
  return ProfileNotifier(
    ref,
    ref.read(profileRepositoryProvider),
  );
});

final profileUpdateController =
    StateNotifierProvider<ProfileUpdateNotifier, AsyncValue<void>>((ref) {
  return ProfileUpdateNotifier(ref, ref.read(profileRepositoryProvider));
});

final uploadLevelTwoImageController =
StateNotifierProvider.autoDispose<UploadLevel2ImageNotifier, AsyncValue<void>>((ref) {
  return UploadLevel2ImageNotifier(ref.read(profileRepositoryProvider));
});