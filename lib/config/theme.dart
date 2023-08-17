import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class AppTheme {
  static var theme = ThemeData(
    primaryColor: primaryColor,
    textTheme: TextTheme(
      titleMedium: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
