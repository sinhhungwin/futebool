import 'package:flutter/material.dart';

/// Text Theme and Color Used in the Project

ThemeData theme() {
  return ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: Colors.white,
    backgroundColor: const Color(0xFFF4F4F4),
    fontFamily: 'Montserrat',
    textTheme: textTheme(),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: const Color(0xFFE84545),
    ),
  );
}

// Colors
const primaryColor = Color(0xFF2B2E4A);

// Text Theme
TextTheme textTheme() {
  return const TextTheme(
    headline1: TextStyle(
        fontFamily: 'Merriweather',
        color: primaryColor,
        fontSize: 36,
        fontWeight: FontWeight.bold),
    headline2: TextStyle(
        fontFamily: 'Merriweather',
        color: primaryColor,
        fontSize: 24,
        fontWeight: FontWeight.bold),
    headline3: TextStyle(
        fontFamily: 'Montserrat',
        color: primaryColor,
        fontSize: 18,
        fontWeight: FontWeight.bold),
    headline4: TextStyle(
        fontFamily: 'Montserrat',
        color: primaryColor,
        fontSize: 16,
        fontWeight: FontWeight.bold),
    headline5: TextStyle(
        fontFamily: 'Montserrat',
        color: primaryColor,
        fontSize: 14,
        fontWeight: FontWeight.bold),
    headline6: TextStyle(
        fontFamily: 'Montserrat',
        color: primaryColor,
        fontSize: 14,
        fontWeight: FontWeight.normal),
    bodyText1: TextStyle(
        fontFamily: 'Montserrat',
        color: primaryColor,
        fontSize: 12,
        fontWeight: FontWeight.normal),
    bodyText2: TextStyle(
        fontFamily: 'Montserrat',
        color: primaryColor,
        fontSize: 10,
        fontWeight: FontWeight.normal),
  );
}
