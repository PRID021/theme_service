import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';

abstract class SystemUtils {
  static SchedulerBinding get instance => SchedulerBinding.instance;
  static SingletonFlutterWindow get window => instance.window;
  static Brightness get brightness => window.platformBrightness;
  static bool get isDarkMode => brightness == Brightness.dark;
}
