import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Tipografia oficial: Inter no corpo + Sacramento nos slots de display
/// (títulos cursivos grandes — hero da home, etc).
abstract final class AppTextStyles {
  static TextTheme build(TextTheme base) {
    final inter = GoogleFonts.interTextTheme(base);
    return inter.copyWith(
      displayLarge: GoogleFonts.sacramento(textStyle: inter.displayLarge),
      displayMedium: GoogleFonts.sacramento(textStyle: inter.displayMedium),
      displaySmall: GoogleFonts.sacramento(textStyle: inter.displaySmall),
    );
  }
}
