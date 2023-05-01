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
  textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.black),
  inputDecorationTheme: const InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(vertical: 10),
    border: UnderlineInputBorder(
      borderSide: BorderSide(color: kBackgroundLightColor, width: 2),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black, width: 2),
    ),
    errorBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 2),
    ),
    focusedErrorBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 2),
    ),
    suffixIconColor: kBodyTextColorLight,
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
  textSelectionTheme: const TextSelectionThemeData(cursorColor: kTextDarkColor),
  inputDecorationTheme: const InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(vertical: 10),
    border: UnderlineInputBorder(
      borderSide: BorderSide(color: kBackgroundDarkColor, width: 2),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: kBackgroundDarkColor, width: 2),
    ),
    errorBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 2),
    ),
    focusedErrorBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 2),
    ),
    suffixIconColor: kBodyTextColorDark,
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
