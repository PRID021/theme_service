import 'package:flutter/material.dart';

/// This is the interface that the [ThemeServiceProvider] implements.
///
/// [changeThemeData] is used to change the theme data of the app without considering the system theme.
/// [changeSystemTheme] is used to change the theme data of the app considering the system theme.
/// [isDarkMode] is used to check if the system theme is dark or not.
/// [darkThemeData] is used to get the dark theme data of the app.
/// [lightThemeData] is used to get the light theme data of the app.
/// [currentThemeData] is used to get the current theme data of the app.
/// [onSystemThemeChanged] is used to listen and reactive to the system theme changes.

abstract class IThemeProvider {
  void changeThemeData({
    required ThemeData themeData,
  });
  void changeSystemTheme({
    required bool changeForDarkTheme,
    required ThemeData themeData,
  });

  void onSystemThemeChanged();

  bool get isDarkMode;
  ThemeData get darkThemeData;
  ThemeData get lightThemeData;
  ThemeData get currentThemeData;
}
