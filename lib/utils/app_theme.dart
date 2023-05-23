
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_color.dart';


class AppTheme {
  static double borderRadius = 7;
  static ThemeData darkTheme = ThemeData(
    fontFamily: GoogleFonts.poppins().fontFamily,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColor.mainColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColor.mainColor,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: AppColor.accentColor,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ),
    bottomNavigationBarTheme:
    BottomNavigationBarThemeData(backgroundColor: AppColor.mainColor),
    primarySwatch: Colors.blue,
    expansionTileTheme: ExpansionTileThemeData(
      collapsedBackgroundColor: AppColor.secondColor,
      backgroundColor: AppColor.secondColor,
      expandedAlignment: Alignment.centerLeft,
      childrenPadding: const EdgeInsets.all(16),
    ),
    cardTheme: CardTheme(
      color: AppColor.secondColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    ),
    listTileTheme: ListTileThemeData(
      tileColor: AppColor.secondColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: AppColor.accentColor,
          ),
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.accentColor,
        textStyle: const TextStyle(
          color: AppColor.textColor,
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ),
        fixedSize: const Size.fromHeight(40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    ),
  );

  static InputDecoration authTextFieldDecoration = InputDecoration(
    errorMaxLines: 2,
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 12,
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: AppColor.accentColor),
      borderRadius: BorderRadius.circular(borderRadius),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColor.accentColor),
      borderRadius: BorderRadius.circular(borderRadius),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.red),
      borderRadius: BorderRadius.circular(borderRadius),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.blue,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(borderRadius),
    ),
  );

  static BoxDecoration containerDecoration = BoxDecoration(
    color: AppColor.secondColor,
    borderRadius: BorderRadius.circular(12),
  );
}

class AppTextStyle {
  static TextStyle yellowTitle = TextStyle(
    fontSize: 17,
    color: AppColor.accentColor,
    fontWeight: FontWeight.bold,
  );
  static TextStyle yellowMedium = TextStyle(
    fontSize: 14,
    color: AppColor.accentColor,
    fontWeight: FontWeight.bold,
  );
}

class AppPadding {
  /// hori 15
  static const EdgeInsets defaultHPadding =
  EdgeInsets.symmetric(horizontal: 8.0);
}