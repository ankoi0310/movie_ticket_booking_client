import 'package:flutter/material.dart';

import 'constants.dart';

// Our light/Primary Theme
ThemeData themeData() {
  return ThemeData.light().copyWith(
    appBarTheme: appBarTheme,
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
}

// Dark Them
ThemeData darkThemeData() {
  return ThemeData.dark().copyWith(
    appBarTheme: appBarDarkTheme,
    primaryColor: kPrimaryColor,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: kBackgroundDarkColor,
    colorScheme: const ColorScheme.dark(
      background: kBackgroundDarkColor,
      secondary: kSecondaryDarkColor,
      surface: kSurfaceDarkColor,
      shadow: Colors.white30,
    ),
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
  );
}

AppBarTheme appBarTheme = const AppBarTheme(
  color: kBackgroundLightColor,
  elevation: 1,
  centerTitle: true,
  iconTheme: IconThemeData(color: kTextLightColor),
  titleTextStyle: TextStyle(
    color: kTextLightColor,
    fontSize: 22,
  ),
  shadowColor: kShadowColor,
);

AppBarTheme appBarDarkTheme = const AppBarTheme(
  color: kBackgroundDarkColor,
  elevation: 1,
  centerTitle: true,
  iconTheme: IconThemeData(color: kTextDarkColor),
  titleTextStyle: TextStyle(
    color: kTextDarkColor,
    fontSize: 22,
  ),
  shadowColor: Colors.white,
);

