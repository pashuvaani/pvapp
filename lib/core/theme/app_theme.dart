import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import '../constants/app_styles.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      splashFactory: InkRipple.splashFactory,
      scaffoldBackgroundColor: const Color(0xFFF7F9F7),
      primaryColor: AppColors.primaryDeepGreen,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryDeepGreen,
        secondary: AppColors.teal,
        tertiary: AppColors.brightAqua,
        surface: Color(0xFFF1F5F2),
        error: AppColors.emergencyRed,
        onPrimary: Colors.white,
        onSurface: Color(0xFF18201C),
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: ZoomPageTransitionsBuilder(),
          TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
          TargetPlatform.windows: ZoomPageTransitionsBuilder(),
          TargetPlatform.macOS: ZoomPageTransitionsBuilder(),
          TargetPlatform.linux: ZoomPageTransitionsBuilder(),
        },
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xFFFFFFFF),
        elevation: 0,
        centerTitle: false,
        iconTheme: const IconThemeData(color: Color(0xFF18201C)),
        titleTextStyle:
            AppStyles.heading2.copyWith(color: const Color(0xFF18201C)),
      ),
      cardTheme: CardThemeData(
        color: const Color(0xFFFFFFFF),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppStyles.cardBorderRadius,
          side: const BorderSide(color: Color(0xFFE1E8E3), width: 1),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryDeepGreen,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: AppStyles.buttonBorderRadius,
          ),
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFFFFFFF),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: AppStyles.inputBorderRadius,
          borderSide: const BorderSide(color: Color(0xFFE1E8E3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppStyles.inputBorderRadius,
          borderSide: const BorderSide(color: Color(0xFFE1E8E3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppStyles.inputBorderRadius,
          borderSide:
              const BorderSide(color: AppColors.primaryDeepGreen, width: 1.5),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: Color(0xFFE1E8E3),
        thickness: 1,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      splashFactory: InkRipple.splashFactory,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF121A18),
      primaryColor: AppColors.primaryDeepGreen,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryDeepGreen,
        secondary: AppColors.teal,
        tertiary: AppColors.brightAqua,
        surface: Color(0xFF19231F),
        error: AppColors.emergencyRed,
        onPrimary: Colors.white,
        onSurface: Color(0xFFF1F5F3),
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: ZoomPageTransitionsBuilder(),
          TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
          TargetPlatform.windows: ZoomPageTransitionsBuilder(),
          TargetPlatform.macOS: ZoomPageTransitionsBuilder(),
          TargetPlatform.linux: ZoomPageTransitionsBuilder(),
        },
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF19231F),
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: Color(0xFFF1F5F3)),
        titleTextStyle: TextStyle(
            color: Color(0xFFF1F5F3),
            fontSize: 18,
            fontWeight: FontWeight.bold),
      ),
      cardTheme: CardThemeData(
        color: const Color(0xFF202C27),
        elevation: 16,
        shadowColor: AppColors.primaryDeepGreen.withValues(alpha: 0.2),
        shape: RoundedRectangleBorder(
          borderRadius: AppStyles.cardBorderRadius,
          side: const BorderSide(color: Color(0xFF30403A), width: 1),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF202C27),
        selectedItemColor: AppColors.primaryDeepGreen,
        unselectedItemColor: Color(0xFFAAB8B2),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryDeepGreen,
          foregroundColor: Colors.white,
          elevation: 16,
          shadowColor: AppColors.primaryDeepGreen.withValues(alpha: 0.2),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: AppStyles.buttonBorderRadius,
          ),
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF202C27),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: AppStyles.inputBorderRadius,
          borderSide: const BorderSide(color: Color(0xFF30403A)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppStyles.inputBorderRadius,
          borderSide: const BorderSide(color: Color(0xFF30403A)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppStyles.inputBorderRadius,
          borderSide:
              const BorderSide(color: AppColors.primaryDeepGreen, width: 1.5),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: Color(0xFF30403A),
        thickness: 1,
      ),
    );
  }
}
