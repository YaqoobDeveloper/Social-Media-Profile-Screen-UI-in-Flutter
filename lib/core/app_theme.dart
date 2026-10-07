import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const background = Colors.white;
  static const dark = Color(0xFF222222);
  static const grey = Color(0xFFA6A6A6);
  static const border = Color(0xFFEDEDED);
  static const accent = Color(0xFFF07A5A);
  static const accentLight = Color(0xFFF79A6E);
  static const blush = Color(0xFFF4C5C8);
  static const gold = Color(0xFFF6B532);
}

class AppTheme {
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.accent),
    fontFamily: GoogleFonts.outfit().fontFamily,
  );
}
