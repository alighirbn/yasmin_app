import 'package:flutter/material.dart';

class AppTheme {
  // Warm and Cozy Palette
  static const Color primaryColor = Color(0xFFB88F63); // Sienna
  static const Color secondaryColor = Color(0xFFCFB9A2); // Tan
  static const Color backgroundColor = Color(0xFF9E6500); // Moccasin
  static const Color surfaceColor = Color(0xFF512E27); // Saddle Brown
  static const Color accentColor = Color(0xFF371A1A); // Light Salmon
  static const Color errorColor = Color(0xFFD32F2F); // Red for errors

  // Light Theme
  static final ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.light(
      primary: primaryColor, // Sienna
      secondary: secondaryColor, // Tan
      background: backgroundColor, // Moccasin
      surface: surfaceColor, // Saddle Brown
      onPrimary: Colors.white, // Text/icon color on primary
      onSecondary: Colors.black, // Text/icon color on secondary
      onBackground: Colors.black, // Text/icon color on background
      onSurface: Colors.white, // Text/icon color on surface
      error: errorColor, // Error color
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor, // Sienna
      foregroundColor: Colors.white, // AppBar text/icon color
      elevation: 4,
    ),
    cardTheme: CardTheme(
      color: surfaceColor, // Saddle Brown
      elevation: 4,
      margin: EdgeInsets.all(8),
    ),
    useMaterial3: true, // Enable Material 3 design
  );

  // Dark Theme
  static final ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.dark(
      primary: surfaceColor, // Saddle Brown
      secondary: accentColor, // Light Salmon
      background: surfaceColor, // Saddle Brown
      surface: primaryColor, // Sienna
      onPrimary: Colors.white, // Text/icon color on primary
      onSecondary: Colors.black, // Text/icon color on secondary
      onBackground: Colors.white, // Text/icon color on background
      onSurface: Colors.white, // Text/icon color on surface
      error: errorColor, // Error color
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: surfaceColor, // Saddle Brown
      foregroundColor: Colors.white, // AppBar text/icon color
      elevation: 4,
    ),
    cardTheme: CardTheme(
      color: primaryColor, // Sienna
      elevation: 4,
      margin: EdgeInsets.all(8),
    ),
    useMaterial3: true, // Enable Material 3 design
  );
}