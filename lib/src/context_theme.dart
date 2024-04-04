import 'package:flutter/material.dart';

extension ThemeExt on BuildContext {
  /// Theme [ThemeData] based on [BuildContext]
  ThemeData get theme => Theme.of(this);

  /// [ColorScheme] from the [ThemeData] of the App
  ColorScheme get colorScheme => theme.colorScheme;

  /// Indicates wheter the app is in dark mode
  bool get isDarkMode => theme.brightness == Brightness.dark;

  /// Indicates wheter the app is in light mode
  bool get isLightMode => theme.brightness == Brightness.light;
}
