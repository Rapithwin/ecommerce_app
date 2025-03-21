import 'package:e_commerce/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.whiteColor,
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.whiteColor,
        primary: AppColors.greyColorLight,
        secondary: AppColors.blackColor,
        tertiary: AppColors.greyColorLight,
        onPrimary: AppColors.blackColor,
        onSecondary: AppColors.whiteColor,
        onTertiary: AppColors.blackColor.withAlpha(150),
        brightness: Brightness.light,
        outline: AppColors.blackColor,
        surface: AppColors.whiteColor,
        onSurface: AppColors.blackColor,
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.blackColor.withAlpha(150),
      ),
    );
  }

  static ThemeData get dark {
    return ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.blackColor,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.blackColor,
          primary: AppColors.greyColorDark,
          secondary: AppColors.whiteColor,
          tertiary: AppColors.greyColorDark.withAlpha(160),
          onPrimary: AppColors.whiteColor,
          onSecondary: AppColors.blackColor,
          onTertiary: AppColors.whiteColor.withAlpha(150),
          brightness: Brightness.dark,
          outline: AppColors.whiteColor,
          surface: AppColors.blackColor,
          onSurface: AppColors.whiteColor,
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: AppColors.whiteColor.withAlpha(150),
        ));
  }
}
