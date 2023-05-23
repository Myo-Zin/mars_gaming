import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/sharepref.dart';


class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier() : super(const Locale('en')) {
    onAppStart();
  }

  void setLocal(Locale locale) {
    try {
      SharePref.setLocale(locale);

      state = Locale(locale.languageCode);
    } catch (error) {
      state = const Locale('my');
    }
  }

  void onAppStart() async {
    try {
      final code = await SharePref.getLocale();
      state = Locale(code);
    } catch (error) {
      state = const Locale('my');
    }
  }
}

final localProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  return LocaleNotifier();
});
