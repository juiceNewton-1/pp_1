import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stocks_tracker/themes/custom_colors.dart';

class AppTheme {
  static TextTheme textTheme() {
    return TextTheme(
      displayLarge: GoogleFonts.raleway(
        fontWeight: FontWeight.w600,
        fontSize: 40.0,
      ),
      displayMedium: GoogleFonts.raleway(
        fontWeight: FontWeight.w400,
        fontSize: 12.0,
      ),
      displaySmall: GoogleFonts.raleway(
        fontWeight: FontWeight.w700,
        fontSize: 28.0,
      ),
      labelLarge: GoogleFonts.raleway(
        fontWeight: FontWeight.w700,
        fontSize: 25.0,
      ),
      labelMedium: GoogleFonts.raleway(
        fontWeight: FontWeight.w600,
        fontSize: 20.0,
      ),
      labelSmall: GoogleFonts.raleway(
        fontWeight: FontWeight.w600,
        fontSize: 14.0,
      ),
      bodyLarge: GoogleFonts.raleway(
        fontWeight: FontWeight.w400,
        fontSize: 20.0,
      ),
      bodyMedium: GoogleFonts.raleway(
        fontWeight: FontWeight.w800,
        fontSize: 16.0,
      ),
      bodySmall: GoogleFonts.raleway(
        fontWeight: FontWeight.w500,
        fontSize: 15.0,
      ),
    );
  }

  static ThemeData light() {
    const Brightness brightness = Brightness.light;
    const Color onBackground = Colors.white;

    return ThemeData(
      brightness: brightness,
      textTheme: textTheme().apply(
        bodyColor: onBackground,
        displayColor: onBackground,
      ),
      extensions: const <ThemeExtension<dynamic>>[
        CustomColors.light,
      ],
      colorScheme: const ColorScheme(
        brightness: brightness,
        primary: Color(0xFFFFFFFF),
        onPrimary: Colors.white,
        secondary: Color(0xFF464646),
        onSecondary: Color(0xFF000000),
        error: Color(0xFFFF1F1F),
        onError: Colors.white,
        background: Color(0xFF000000),
        onBackground: onBackground,
        surface: Color(0xFFFFFFFF),
        onSurface: Color(0xFFFFFFFF),
      ),
    );
  }
}
