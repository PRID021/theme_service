import 'package:flutter/material.dart';

class ThemeService extends InheritedWidget {
  final Function({required ThemeData themeData}) onChangeThemeData;

  final void Function({
    required bool changeForDarkTheme,
    required ThemeData themeData,
  }) onChangeSystemTheme;

  final void Function({
    ThemeData? lightThemeData,
    ThemeData? darkThemeData,
  }) onChangeSystemThemeV2;

  final void Function({
    required Function action,
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
    required this.onChangeSystemThemeV2,
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
    return this != oldWidget;
  }

  void changeSystemTheme(
      {required bool isDarkMode, required ThemeData themeData}) {
    onChangeSystemTheme(changeForDarkTheme: isDarkMode, themeData: themeData);
  }

  void changeSystemThemeV2(
      {ThemeData? lightThemeData, ThemeData? darkThemeData}) {
    onChangeSystemThemeV2(
        lightThemeData: lightThemeData, darkThemeData: darkThemeData);
  }

  void changeThemeData({required ThemeData themeData}) {
    onChangeThemeData(themeData: themeData);
  }

  void rollBackThemeScope(
      {required Function action,
      required Future<bool> Function() confirmAction}) {
    rollBackScope.call(action: action, confirmAction: confirmAction);
  }
}
