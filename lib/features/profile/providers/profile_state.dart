import 'package:freezed_annotation/freezed_annotation.dart';


import '../models/profile_response.dart';

part 'profile_state.freezed.dart';


@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState.loading()=_Loading;
  const factory ProfileState.data(ProfileData profileData) = _Data;
  const factory ProfileState.unAuthenticated() = _UnAuthenticated;
  const factory ProfileState.error(String message)=_Error;
}
