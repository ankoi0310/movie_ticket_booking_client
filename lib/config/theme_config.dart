import 'package:movie_ticket_booking_flutter_nlu/core.dart';

/// Description: This is the light theme of the app
final lightTheme = ThemeData.light().copyWith(
  useMaterial3: true,
  primaryColor: primaryColor,
  brightness: Brightness.light,
  scaffoldBackgroundColor: LightTheme.backgroundColor,
  canvasColor: LightTheme.backgroundColor,
  colorScheme: const ColorScheme.light(
    primary: primaryColor,
    secondary: secondaryColor,
    tertiary: accentColor,
    background: LightTheme.backgroundColor,
    shadow: LightTheme.shadowColor,
  ),
  primaryTextTheme: const TextTheme().apply(
    bodyColor: LightTheme.textColor,
    displayColor: LightTheme.textColor,
  ),
  primaryIconTheme: const IconThemeData(color: LightTheme.iconColor),
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
    ),
  ),
  iconTheme: const IconThemeData(color: LightTheme.iconColor),
);

/// Description: This is the dark theme of the app
final darkTheme = ThemeData.dark().copyWith(
  useMaterial3: true,
  primaryColor: primaryColor,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: DarkTheme.backgroundColor,
  colorScheme: const ColorScheme.dark(
    primary: primaryColor,
    secondary: secondaryColor,
    tertiary: accentColor,
    background: DarkTheme.backgroundColor,
    shadow: DarkTheme.shadowColor,
  ),
  primaryTextTheme: const TextTheme().apply(
    bodyColor: DarkTheme.textColor,
    displayColor: DarkTheme.textColor,
  ),
  iconTheme: const IconThemeData(color: DarkTheme.iconColor),
);
