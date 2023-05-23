import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharePref {
  static const String authToken = "Auth";
  static const String language = "locale";

  static Future<void> setAuth(String token) async {
    final shp = await SharedPreferences.getInstance();
    shp.setString(authToken, token);
  }

  static Future<String?> getAuth() async {
    final shp = await SharedPreferences.getInstance();
    final result = shp.getString(authToken);
    return result;
  }

  static Future<void> clear() async {
    final shp = await SharedPreferences.getInstance();
    shp.clear();
  }

  static Future<void> setLocale(Locale locale)async {
    final sp = await SharedPreferences.getInstance();
    sp.setString(language, locale.languageCode);

  }
  static Future<String> getLocale() async {
    final shp = await SharedPreferences.getInstance();
    final result = shp.getString(language)??"my";
    return result;
  }
}
