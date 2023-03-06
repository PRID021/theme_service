import 'package:flutter/material.dart';

class ThemeService extends InheritedWidget {
  final Function({required ThemeData themeData}) onChangeThemeData;

  final void Function({
    required bool changeForDarkTheme,
    required ThemeData themeData,
  }) onChangeSystemTheme;

  final void Function({
    required Function nextAction,
    required Future<bool> Function() confirmAction,
  }) rollBackScope;

  const ThemeService({
    super.key,
    required super.child,
    required this.onChangeThemeData,
    required this.onChangeSystemTheme,
    required ThemeData lightThemeData,
    required ThemeData darkThemeData,
    required ThemeData currentThemeData,
    required this.rollBackScope,
  })  : _lightThemeData = lightThemeData,
        _darkThemeData = darkThemeData,
        _currentThemeData = currentThemeData;

  final ThemeData _lightThemeData;
  final ThemeData _darkThemeData;
  final ThemeData _currentThemeData;

  ThemeData get currentThemeData => _currentThemeData;

  ThemeData get darkThemeData => _darkThemeData;

  ThemeData get lightThemeData => _lightThemeData;

  @override
  bool updateShouldNotify(covariant ThemeService oldWidget) {
    return true;
  }

  void changeSystemTheme(
      {required bool isDarkMode, required ThemeData themeData}) {
    onChangeSystemTheme(changeForDarkTheme: isDarkMode, themeData: themeData);
  }

  void changeThemeData({required ThemeData themeData}) {
    onChangeThemeData(themeData: themeData);
  }

  void rollBackThemeScope(
      {required Function nextAction,
      required Future<bool> Function() confirmAction}) {
    rollBackScope.call(nextAction: nextAction, confirmAction: confirmAction);
  }
}
