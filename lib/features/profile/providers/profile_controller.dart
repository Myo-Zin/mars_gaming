import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/failure.dart';
import '../../auth/providers/providers.dart';
import '../repositories/profile_repository.dart';
import 'profile_state.dart';


class ProfileNotifier extends StateNotifier<ProfileState> {
  final Ref ref;
  final ProfileRepository _profileRepository;
  ProfileNotifier(
    this.ref,
    this._profileRepository,
  ) : super(const ProfileState.loading()) {
    final authState = ref.watch(authControllerProvider);
    authState.maybeMap(
      authenticated: (value) {
        getProfile(value.token);
      },
      orElse: () {
        state = const ProfileState.unAuthenticated();
      },
    );
  }

  refreshProfile() {
    final authState = ref.read(authControllerProvider);
    authState.maybeMap(
      authenticated: (value) {
        getProfile(value.token);
      },
      orElse: () {
        state = const ProfileState.unAuthenticated();
      },
    );
  }

  getProfile(String token) async {
    final result = await _profileRepository.getProfile(token);
    if (mounted) {
      result.fold(
        (l) {
          if (l.reason == FailureReason.authError) {
            ref.read(authControllerProvider.notifier).logout();
          }
          if (l.reason == FailureReason.normalError) {
            ref.read(authControllerProvider.notifier).logout();
          }
          if (mounted) {
            state = ProfileState.error(l.message);
          }
        },
        (profile) {
          state = ProfileState.data(profile.copyWith(token: token));
        },
      );
    }
  }


}
