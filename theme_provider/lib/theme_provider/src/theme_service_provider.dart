import 'dart:ui';
import 'package:flutter/material.dart';
import 'i_theme_provider.dart';
import 'theme_provider_data.dart';
import 'theme_mode_notifier.dart';

class ThemeServiceProvider extends StatefulWidget {
  static ThemeService of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeService>()!;
  }

  final ThemeData? theme;
  final ThemeData? darkTheme;
  final ThemeData? inItTheme;
  final bool autoReactiveOnSystemThemeChange;

  final Widget child;
  const ThemeServiceProvider({
    super.key,
    required this.child,
    this.theme,
    this.darkTheme,
    this.inItTheme,
    this.autoReactiveOnSystemThemeChange = true,
  });

  @override
  State<ThemeServiceProvider> createState() => ThemeServiceProviderState();
}

class ThemeServiceProviderState extends State<ThemeServiceProvider>
    with WidgetsBindingObserver
    implements IThemeProvider {
  /// [autoReactiveOnSystemThemeChange] flag to enable/disable auto change theme
  /// when system theme change
  late final bool autoReactiveOnSystemThemeChange;

  /// [lightThemeData] theme data for light theme mode.
  late ThemeData _lightThemeData;

  /// [darkThemeData] theme data for dark theme mode.
  late ThemeData _darkThemeData;

  /// [currentThemeData] theme data  current be used.
  late ThemeData _currentThemeData;

  /// [_widgetsBinding], [_window], [_themeModeNotifier]  use to track the system theme
  late final WidgetsBinding _widgetsBinding;
  late final FlutterWindow _window;
  late final ThemeModeNotifier _themeModeNotifier;

  @override
  void didChangePlatformBrightness() {
    _themeModeNotifier
        .changeBrightness(_window.platformDispatcher.platformBrightness);
    super.didChangePlatformBrightness();
  }

  @override
  void initState() {
    // Setting the initial theme
    _lightThemeData = widget.theme ??
        ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light().copyWith(
          primary: Colors.red,
        ));
    _darkThemeData = widget.darkTheme ??
        ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.light().copyWith(
          primary: Colors.blue,
        ));

    // init reactive mode.
    autoReactiveOnSystemThemeChange = widget.autoReactiveOnSystemThemeChange;

    // Setting Observer to track the system theme
    _widgetsBinding = WidgetsBinding.instance;
    _widgetsBinding.addObserver(this);
    _window = _widgetsBinding.window;
    _themeModeNotifier =
        ThemeModeNotifier(_window.platformDispatcher.platformBrightness);
    _themeModeNotifier.addListener(onSystemThemeChanged);

    // Setting the initial theme
    if (widget.inItTheme != null) {
      _currentThemeData = widget.inItTheme!;
    }
    if (_window.platformDispatcher.platformBrightness == Brightness.dark &&
        widget.inItTheme == null) {
      _currentThemeData = _darkThemeData;
    }
    if (_window.platformDispatcher.platformBrightness == Brightness.light &&
        widget.inItTheme == null) {
      _currentThemeData = _lightThemeData;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeService(
      lightThemeData: _lightThemeData,
      darkThemeData: _darkThemeData,
      currentThemeData: _currentThemeData,
      onChangeSystemTheme: changeSystemTheme,
      onChangeThemeData: changeThemeData,
      child: widget.child,
    );
  }

  @override
  void changeSystemTheme({
    required bool changeForDarkTheme,
    required ThemeData themeData,
  }) {
    if (changeForDarkTheme) {
      _darkThemeData = themeData;
      print(
          "config for dark theme changed with new config ${themeData.colorScheme.primary}");
      onConfigThemeChanged(isChangeForDarkTheme: changeForDarkTheme);
      return;
    }
    if (!changeForDarkTheme) {
      _lightThemeData = themeData;
      print(
          "config for light theme changed with new config ${themeData.colorScheme.primary}");
      onConfigThemeChanged(isChangeForDarkTheme: changeForDarkTheme);
    }
  }

  void onConfigThemeChanged({required bool isChangeForDarkTheme}) {
    if (!autoReactiveOnSystemThemeChange) return;
    if (isChangeForDarkTheme && _themeModeNotifier.value == Brightness.dark) {
      setState(() {
        _currentThemeData = _darkThemeData;
      });
      return;
    }

    if (!isChangeForDarkTheme && _themeModeNotifier.value == Brightness.light) {
      setState(
        () {
          _currentThemeData = _lightThemeData;
        },
      );
      return;
    }
  }

  @override
  void changeThemeData({
    required ThemeData themeData,
  }) {
    setState(() {
      _currentThemeData = themeData;
    });
  }

  @override
  ThemeData get currentThemeData => _currentThemeData;

  @override
  ThemeData get darkThemeData => _darkThemeData;

  @override
  bool get isDarkMode => _currentThemeData == _darkThemeData;

  @override
  ThemeData get lightThemeData => _lightThemeData;

  @override
  void onSystemThemeChanged() {
    if (!autoReactiveOnSystemThemeChange) return;
    if (_themeModeNotifier.value == Brightness.dark) {
      setState(() {
        _currentThemeData = _darkThemeData;
      });
      return;
    }
    setState(() {
      _currentThemeData = _lightThemeData;
    });
  }
}
