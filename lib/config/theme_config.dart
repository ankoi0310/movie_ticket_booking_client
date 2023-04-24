import 'package:flutter/material.dart';

import '../style/color.dart';

/// Description: This is the light theme of the app
final lightTheme = ThemeData.light().copyWith(
  appBarTheme: appBarLightTheme,
  primaryColor: kPrimaryColor,
  brightness: Brightness.light,
  scaffoldBackgroundColor: kBackgroundLightColor,
  colorScheme: const ColorScheme.light(
    secondary: kSecondaryLightColor,
    background: kBackgroundLightColor,
    surface: kBackgroundLightColor,
    shadow: kShadowColor,
  ),
  iconTheme: const IconThemeData(color: kPrimaryIconColor),
  useMaterial3: true,
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Colors.black,
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: kBackgroundLightColor,
        width: 2,
      ),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.black,
        width: 2,
      ),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red,
        width: 2,
      ),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red,
        width: 2,
      ),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
  ),
);

/// Description: This is a custom app bar theme for light theme
const appBarLightTheme = AppBarTheme(
  color: Colors.transparent,
  elevation: 0,
  centerTitle: true,
  iconTheme: IconThemeData(color: kTextLightColor),
  titleTextStyle: TextStyle(
    color: kTextLightColor,
    fontSize: 22,
  ),
  shadowColor: Colors.transparent,
);

/// Description: This is the dark theme of the app
final darkTheme = ThemeData.dark().copyWith(
  appBarTheme: appBarDarkTheme,
  primaryColor: kPrimaryColor,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: kBackgroundDarkColor,
  iconTheme: const IconThemeData(color: kPrimaryIconColor),
  useMaterial3: true,
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: kTextDarkColor,
  ),
  inputDecorationTheme: const InputDecorationTheme(
    filled: true,
    fillColor: kSecondaryDarkColor,
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: kSecondaryDarkColor,
        width: 2,
      ),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: kTextDarkColor,
        width: 2,
      ),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red,
        width: 2,
      ),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red,
        width: 2,
      ),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
  ),
  colorScheme: const ColorScheme.dark(
    background: kBackgroundDarkColor,
    secondary: kSecondaryDarkColor,
    surface: kSurfaceDarkColor,
    shadow: Colors.white30,
  ).copyWith(background: kBackgroundDarkColor),
);

/// Description: This is a custom app bar theme for dark theme
const appBarDarkTheme = AppBarTheme(
  color: Colors.transparent,
  elevation: 0,
  centerTitle: true,
  iconTheme: IconThemeData(color: kTextDarkColor),
  titleTextStyle: TextStyle(
    color: kTextDarkColor,
    fontSize: 22,
  ),
  shadowColor: Colors.white,
);
