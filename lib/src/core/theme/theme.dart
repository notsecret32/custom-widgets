import 'package:flutter/material.dart';

import './colors.dart';

/// Application appearance settings.
final ThemeData customWidgetsTheme = ThemeData(
  useMaterial3: true,
  shadowColor: shadowColor,
  primaryColor: primaryColor,
  colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
  scaffoldBackgroundColor: const Color(0xFFEFEFEF),
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    backgroundColor: primaryColor,
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 30,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    labelLarge: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    labelMedium: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 24,
      fontWeight: FontWeight.w500,
    ),
    titleSmall: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 18,
      fontWeight: FontWeight.normal,
    ),
    bodySmall: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 16,
      fontWeight: FontWeight.w300,
      color: Color(0xFF747474),
    ),
  ),
);
