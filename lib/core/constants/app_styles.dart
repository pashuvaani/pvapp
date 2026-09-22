import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppStyles {
  // Border Radius System (Large rounded cards)
  static const double radiusSmall = 10.0;
  static const double radiusMedium = 16.0;
  static const double radiusLarge = 24.0;
  static const double radiusXLarge = 32.0;

  static final BorderRadius cardBorderRadius = BorderRadius.circular(radiusMedium);
  static final BorderRadius buttonBorderRadius = BorderRadius.circular(radiusXLarge);
  static final BorderRadius inputBorderRadius = BorderRadius.circular(radiusSmall + 4);

  // Soft Shadows
  static const BoxShadow softShadow = BoxShadow(
    color: Color(0x0A08765B),
    blurRadius: 20,
    offset: Offset(0, 6),
    spreadRadius: 0,
  );

  static const BoxShadow cardShadow = BoxShadow(
    color: Color(0x0D1E2933),
    blurRadius: 16,
    offset: Offset(0, 4),
  );

  static List<BoxShadow> getBoxShadow(BuildContext context) {
    if (Theme.of(context).brightness == Brightness.dark) {
      return [
        BoxShadow(
          color: AppColors.primaryDeepGreen.withValues(alpha: 0.15),
          blurRadius: 40,
          spreadRadius: 8,
        ),
        BoxShadow(
          color: AppColors.primaryDeepGreen.withValues(alpha: 0.4),
          blurRadius: 20,
          spreadRadius: 2,
        ),
      ];
    }
    return [
      BoxShadow(
        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.05),
        blurRadius: 10,
        offset: const Offset(0, 4),
      )
    ];
  }

  static const BoxShadow glowShadow = BoxShadow(
    color: Color(0x3339C9C2),
    blurRadius: 24,
    spreadRadius: 2,
    offset: Offset(0, 8),
  );

  // 🔤 Typography - Pashuvaani Font System (Nunito)
  
  static TextStyle screenTitle = TextStyle(
    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryText,
    letterSpacing: -0.5,
  );

  static TextStyle heading1 = TextStyle( // Main Heading
    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryText,
    letterSpacing: -0.3,
  );

  static TextStyle heading2 = TextStyle( // Section Heading
    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryText,
  );

  static TextStyle heading3 = TextStyle( // Card Title
    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryText,
  );

  static TextStyle bodyText = TextStyle(
    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.primaryText,
    height: 1.45,
  );

  static TextStyle subtext = TextStyle( // Small Description
    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.secondaryText,
  );

  static TextStyle buttonText = TextStyle(
    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static TextStyle navigationText = TextStyle(
    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: AppColors.secondaryText,
  );

  static TextStyle priceText = TextStyle(
    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryDeepGreen,
  );
}
