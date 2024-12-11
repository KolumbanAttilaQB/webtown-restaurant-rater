import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  getTheme() {
    return ThemeData(
        visualDensity: VisualDensity.standard,
       scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
        fontFamily: GoogleFonts.merriweather().fontFamily,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red,
        ),
        textTheme: TextTheme(
          displayLarge: const TextStyle(
            fontSize: 72,
            fontWeight: FontWeight.bold,
          ),
          titleLarge: GoogleFonts.merriweather(
            fontSize: 30,
            fontStyle: FontStyle.normal,
          ),
          bodyMedium: GoogleFonts.merriweather(),
          displaySmall: GoogleFonts.merriweather(),
        ),
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        )
      )
    );
  }
}


