import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background,

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: AppColors.primary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.surface,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.textPrimary),
        titleTextStyle:  TextStyle(color: AppColors.textPrimary, fontSize: 20, fontWeight: FontWeight.bold),
      ),

      tabBarTheme: const TabBarTheme(
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.textSecondary,
        indicatorColor: AppColors.primary,
      ),

      textTheme:  TextTheme(
        titleLarge: AppTextStyles.headline0,
        titleMedium: AppTextStyles.headline1,
        titleSmall: AppTextStyles.headline3,
        displayLarge: AppTextStyles.headline2,
        displayMedium: AppTextStyles.body,
        displaySmall: AppTextStyles.caption,
      ),
      colorScheme: ColorScheme.light(
        // 기본 색상
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        error: AppColors.error,
        background: AppColors.background,
        surface: AppColors.surface,
        surfaceVariant: AppColors.background.withOpacity(0.95),

        // 텍스트/아이콘 색상
        onPrimary: AppColors.textWhite,
        onSecondary: AppColors.textWhite,
        onBackground: AppColors.textPrimary,
        onSurface: AppColors.textPrimary,
        onSurfaceVariant: AppColors.textSecondary,
        onError: AppColors.textWhite,

        // 구분선 및 기타
        outline: AppColors.divider,
        outlineVariant: AppColors.divider.withOpacity(0.5),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),

    );
  }
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.primaryDark,
      scaffoldBackgroundColor: AppColors.backgroundDark,

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: AppColors.primaryDark,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.surfaceDark,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.textWhite),
        titleTextStyle: TextStyle(color: AppColors.textWhite, fontSize: 20, fontWeight: FontWeight.bold),
      ),

      tabBarTheme: const TabBarTheme(
        labelColor: AppColors.primaryDark,
        unselectedLabelColor: AppColors.textSecondaryDark,
        indicatorColor: AppColors.primaryDark,
      ),

      textTheme: TextTheme(
        titleLarge: AppTextStyles.headline0Dark,
        titleMedium: AppTextStyles.headline1Dark,
        titleSmall: AppTextStyles.headline3Dark,
        displayLarge: AppTextStyles.headline2Dark,
        displayMedium: AppTextStyles.bodyDark,
        displaySmall: AppTextStyles.captionDark,
      ),

      colorScheme: ColorScheme.dark(
        primary: AppColors.primaryDark,
        secondary: AppColors.secondaryDark,
        error: AppColors.error,
        background: AppColors.backgroundDark,
        surface: AppColors.surfaceDark,
        surfaceVariant: AppColors.surfaceDark.withOpacity(0.95),

        onPrimary: AppColors.textWhite,
        onSecondary: AppColors.textWhite,
        onBackground: AppColors.textWhite,
        onSurface: AppColors.textWhite,
        onSurfaceVariant: AppColors.textSecondaryDark,
        onError: AppColors.textWhite,

        outline: AppColors.dividerDark,
        outlineVariant: AppColors.dividerDark.withOpacity(0.5),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryDark,
          foregroundColor: Colors.white,
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

}
