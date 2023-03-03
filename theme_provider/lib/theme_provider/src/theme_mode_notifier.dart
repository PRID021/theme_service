import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ThemeModeNotifier extends ValueNotifier<Brightness> {
  ThemeModeNotifier(Brightness brightness) : super(brightness);

  void changeBrightness(Brightness brightness) {
    value = brightness;
    notifyListeners();
  }
}
