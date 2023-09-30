import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class AppTheme {
  static var theme = ThemeData(
    primaryColor: primaryColor,
    useMaterial3: true,
    textTheme: TextTheme(
      titleMedium: GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
