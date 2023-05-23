import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/update_profile_form.dart';
import '../repositories/profile_repository.dart';


class ProfileUpdateNotifier extends StateNotifier<AsyncValue<void>> {
  final Ref ref;
  final ProfileRepository _profileRepository;

  ProfileUpdateNotifier(this.ref, this._profileRepository)
      : super(const AsyncData(null));

  Future<bool> updateProfile({required UpdateProfileForm uf}) async {
    state = const AsyncLoading();
    final result = await _profileRepository.updateProfile(
        token: uf.token,
        name: uf.name,
        image: uf.image,
        email: uf.email,
        birthday: uf.birthday,
        referral: uf.referral);

    return result.fold(
      (l) {
        state = AsyncValue.error(
          l.message,
          StackTrace.empty,
        );
        return false;
      },
      (r) {

        state = const AsyncData(null);
        return true;
      },
    );
  }
}
