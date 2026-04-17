import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      headlineLarge: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      titleLarge: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      bodyLarge: const TextStyle(fontSize: 16),
      bodyMedium: const TextStyle(fontSize: 14, color: Colors.grey),
    ),

    appBarTheme: AppBarTheme(
      centerTitle: true,
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
