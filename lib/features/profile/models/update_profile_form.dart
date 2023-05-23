

import 'dart:io';

class UpdateProfileForm{
  final String token;
  final String name;
  final File? image;
  final String?  email;
  final String? birthday;
  final String? referral;

  UpdateProfileForm({
    required this.token,
    required this.name,
    this.image,
    this.email,
    this.birthday,
    this.referral,
  });
}