import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../utils/dio_exception.dart';
import '../../../utils/failure.dart';
import '../models/profile_response.dart';
import '../service/profile_service.dart';

class ProfileRepository {
  ProfileRepository(this._profileService);

  final ProfileService _profileService;

  Future<Either<Failure, ProfileData>> getProfile(String token) async {
    try {
      final result = await _profileService.getProfile(token);
      return right(result);
    } on DioError catch (e) {
      return left(DioException.fromDioError(e).failure);
    }
  }

  Future<Either<Failure, bool>> updateProfile({
    required String token,
    required String name,
    File? image,
    String? email,
    String? birthday,
    String? referral,
  }) async {
    try {
      final result = await _profileService.updateProfile(
          token: token,
          name: name,
          image: image,
          email: email,
          birthday: birthday,
          referral: referral);
      return right(result);
    } on DioError catch (e) {
      return left(DioException.fromDioError(e).failure);
    }
  }

  Future<Either<Failure, bool>> uploadLeve2Image({
    required String token,
    File? file,
  }) async {
    try {
      final result =
          await _profileService.uploadLevel2Image(token: token, image: file);
      return right(result);
    } on DioError catch (e) {
      return left(DioException.fromDioError(e).failure);
    }
  }
}
