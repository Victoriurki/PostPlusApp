import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAppTheme {
  static Color backgroundGradientColorA = const Color(0xFFFFEEF6);
  static Color backgroundGradientColorB = const Color(0xFFF9F9F9);
  static Color greyColor = const Color(0xFF595959);
  static Color softGreyColor = const Color(0xFFC4C4C4);
  static Color softBlueColor = const Color.fromARGB(255, 152, 205, 255);
  final titleFont = GoogleFonts.oleoScript().fontFamily;
  final bodyFont = GoogleFonts.montserrat().fontFamily;

  static ThemeData theme = ThemeData(
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.bold,
        color: greyColor,
        fontFamily: GoogleFonts.oleoScript().fontFamily,
        letterSpacing: 1,
      ),
      titleMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: greyColor,
        fontFamily: GoogleFonts.montserrat().fontFamily,
        letterSpacing: 1,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w300,
        color: greyColor,
        fontFamily: GoogleFonts.montserrat().fontFamily,
      ),
      headlineLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w400,
        color: greyColor,
        fontFamily: GoogleFonts.oleoScript().fontFamily,
        letterSpacing: 1,
      ),
    ),
  );
}
