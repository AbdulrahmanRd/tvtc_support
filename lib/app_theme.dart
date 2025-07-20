import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF0066B2); // TVTC Blue
  static const Color secondaryColor = Color(0xFFF5F5F5); // Light Gray
  static const Color accentColor = Color(0xFFFFA000); // Amber
  static const Color textColor = Color(0xFF333333); // Dark Gray
  static const Color errorColor = Color(0xFFD32F2F); // Red

  static ThemeData get lightTheme {
    // Load the font family that supports Arabic
    final baseTextTheme = ThemeData.light().textTheme;
    
    return ThemeData(
      primaryColor: primaryColor,
      colorScheme: ColorScheme.light(
        primary: primaryColor,
        secondary: accentColor,
        error: errorColor,
      ),
      scaffoldBackgroundColor: Colors.white,
      fontFamily: GoogleFonts.cairo().fontFamily, // Using Cairo font which has great Arabic support
      textTheme: GoogleFonts.cairoTextTheme(baseTextTheme).copyWith(
        displayLarge: GoogleFonts.cairo(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
        displayMedium: GoogleFonts.cairo(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
        titleLarge: GoogleFonts.cairo(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
        bodyLarge: GoogleFonts.cairo(
          fontSize: 16,
          color: textColor,
        ),
        bodyMedium: GoogleFonts.cairo(
          fontSize: 14,
          color: textColor,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        titleTextStyle: GoogleFonts.cairo(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}

// Extension for text styles
extension TextThemeExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
  
  TextStyle get titleLarge => textTheme.titleLarge!;
  TextStyle get bodyLarge => textTheme.bodyLarge!;
  TextStyle get bodyMedium => textTheme.bodyMedium!;
}
