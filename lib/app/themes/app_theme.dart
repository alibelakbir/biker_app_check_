import 'package:flutter/material.dart';
import 'package:biker_app/app/themes/app_colors.dart';

class AppThemes {
  AppThemes._();

  static final ThemeData themData = ThemeData(
      primarySwatch: AppColors.kPrimaryColor,
      primaryColor: AppColors.kPrimaryColor,
      scaffoldBackgroundColor: Color(0xFFFFFFFF),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: const AppBarTheme(scrolledUnderElevation: 0),
      brightness: Brightness.dark,
      //textTheme: GoogleFonts.sourceSansProTextTheme(),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          shape: CircleBorder(), backgroundColor: AppColors.kPrimaryColor),
      splashColor: AppColors.kPrimaryColor.withOpacity(0.2),
      highlightColor: AppColors.kPrimaryColor.withOpacity(0.2));
}
