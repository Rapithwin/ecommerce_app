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
        primary: AppColors.whiteColor,
        secondary: AppColors.blackColor,
        tertiary: AppColors.tertiaryColor,
        brightness: Brightness.light,
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
        primary: AppColors.blackColor,
        secondary: AppColors.whiteColor,
        tertiary: AppColors.tertiaryColor,
        brightness: Brightness.dark,
      ),
    );
  }
}
