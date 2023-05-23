import 'package:flutter/material.dart';
import 'package:mars_gaming/l10n/util.dart';



class L10n {
  static final all = [
    const Locale("my"),
    const Locale('en'),
    const Locale.fromSubtags(languageCode: "zh"),
    const Locale("th")
  ];

  static String getFlag(String code) {
    switch (code) {
      case "my":
        return myanmar;
      case "zh":
        return chinese;
      case "th":
        return thai;
      case "en":
        default:
        return english;
    }
  }

  static String getLanguage(String code) {
    switch (code) {
      case "my":
        return "Myanmar";

      case "zh":
        return "Chinese";
      case "th":
        return "Thai";
      case "en":
      default:
        return "English";
    }
  }
}
