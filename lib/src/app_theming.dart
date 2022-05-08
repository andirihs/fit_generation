import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData getLightThemeData() {
    return FlexThemeData.light(
      scheme: FlexScheme.mango,
      appBarStyle: FlexAppBarStyle.background,
    );
  }

  static ThemeData getDarkThemeData() {
    return FlexThemeData.dark(
      scheme: FlexScheme.mango,
      appBarStyle: FlexAppBarStyle.background,
    );
  }
}
