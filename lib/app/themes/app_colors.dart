import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const MaterialColor kPrimaryColor = MaterialColor(
    0xFF008f8d,
    <int, Color>{
      50: Color(0x88FFC7FF),
      100: Color(0xFFFFC7FF),
      200: Color(0xFFF1A6AA),
      300: Color(0xFFFF99E0),
      400: Color(0xFFFF6DA3),
      500: Color(0xFFEE4463),
      600: Color(0xFFEE4463),
      700: Color(0xFFEE4463),
      800: Color(0xFFEE4463),
      900: Color(0xFF895E6B),
    },
  );

  static const Color kSecondaryColor = Color(0xFF00B6B3); // slightly lighter
  static const Color kAccentColor = Color(0xFF005F5E); // slightly darker

  static const Color kBackgroundColor = Color(0xFFFAFAFA);
  static const Color kLightBackgroundColor =
      Color(0xFFF5FDFD); // very light teal-white
  static const Color kLightSurfaceColor =
      Color(0xFFE0F7F6); // soft background for cards
  static const Color kLightTextColor =
      Color(0xFF003737); // dark teal-gray for readable text

  static const Color white = Colors.white;
  static const Color black = Color(0xFF000000);
  static const Color transparent = Color(0x00000000);
  static const Color green = Color(0xFF43A838);
  static const Color red = Color(0xFFFF3B3B);
  static const Color gray = Color(0xFF7C7C7C);
  static const Color lightGray = Color(0xFF909296);
  static const Color colorDivider = Color(0xFFDDDDDD);
  static const Color blue = Color(0xFF4D81E7);

  static const Color neutral6 = Color(0xFFF1F2F9);
  static const Color neutral3 = Color(0xFFADAFC5);
}

/// Class containing the supported color schemes.
class ColorSchemes {
  final base = ThemeData.light();

  static const primaryColorScheme = ColorScheme.light(
    // Primary colors
    primary: AppColors.kPrimaryColor,
    primaryContainer: AppColors.black,

    // Error colors
    errorContainer: Color(0XFFD9443B),
    onErrorContainer: Color(0XFF0D0D0D),

    // On colors(text colors)
    onPrimary: Color(0XFF171717),
    onPrimaryContainer: Color(0XFFD1D1D1),
  );
}
