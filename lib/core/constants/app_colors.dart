import 'package:flutter/material.dart';

class AppColors {
  // Official Color Palette from User
  static const Color primaryDeepGreen = Color(0xFF0A7952); // 🟢 1. Primary Brand Green
  static const Color primaryGreen = Color(0xFF0A7952);     
  
  static const Color darkTeal = Color(0xFF11433D);         // 🌿 2. Dark Teal Green
  static const Color teal = Color(0xFF11433D);             // fallback mapping

  static const Color softMint = Color(0xFFE9F0EC);         // 💚 3. Light Green Background
  static const Color lightMintBg = Color(0xFFE9F0EC);      
  
  static const Color mediumLightGreen = Color(0xFFCEDDD7); // 🟢 4. Medium Light Green
  static const Color borderDivider = Color(0xFFCEDDD7);    // mapped

  static const Color appBackground = Color(0xFFFEFEFE);    // ⚪ 5. Main Background
  static const Color cardWhite = Color(0xFFFEFEFE);        // mapped
  
  static const Color secondaryBackground = Color(0xFFF7F8F8); // 🩶 6. Secondary Background

  // Categories
  static const Color warmGold = Color(0xFFBE8D5A);         // 🟨 7. Warm Gold
  static const Color softYellowAccent = Color(0xFFBE8D5A); // mapped
  
  static const Color softCream = Color(0xFFF1D3AF);        // 🟡 8. Soft Cream
  static const Color healthBlue = Color(0xFF115484);       // 🔵 9. Health Records Blue
  
  static const Color emergencyRed = Color(0xFFDD412E);     // 🔴 10. Emergency Red

  // Text Colors
  static const Color primaryText = Color(0xFF171510);      // Main Text
  static const Color secondaryText = Color(0xFF586C62);    // Secondary Text
  static const Color mutedText = Color(0xFF798C86);        // Muted Text
  static const Color textGreen = Color(0xFF11433D);        // Primary Dark Green Text

  // Keeping variables to avoid compilation errors on old colors
  static const Color brightAqua = Color(0xFF0A7952); 
  static const Color freshLimeAccent = Color(0xFF0A7952); 

  // Gradients
  static const LinearGradient mainGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF0A7952),
      Color(0xFF11433D),
    ],
  );

  static const LinearGradient brandAccentGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFF0A7952),
      Color(0xFF11433D),
    ],
  );
  static const LinearGradient brandSignatureGradient = brandAccentGradient;

  static const LinearGradient mintCardGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFFEFEFE),
      Color(0xFFE9F0EC),
    ],
  );
}
