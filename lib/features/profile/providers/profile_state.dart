import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mars_gaming/features/home/pages/first_page.dart';

import '../models/profile_response.dart';

part 'profile_state.freezed.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState.loading() = _Loading;
  const factory ProfileState.data(ProfileData profileData) = _Data;
  const factory ProfileState.unAuthenticated() = _UnAuthenticated;
  const factory ProfileState.error(String message) = _Error;
}

extension Profile on ProfileState {
  ProfileData? profile() {
    return maybeWhen(
      data: (profileData) {
        return profileData;
      },
      orElse: () {
        return null;
      },
    );
  }

  bool showWallet() {
    final user = profile();
    return user?.id != walletHideAccountId && user != null;
  }
}
