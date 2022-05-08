import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

/// Play with the default FlexColorSchemes: https://rydmike.com/flexcolorscheme/themesplayground-v5/#/
/// https://docs.flexcolorscheme.com/
class AppTheme {
  static ThemeData getLightThemeData() {
    return FlexThemeData.light(
      scheme: FlexScheme.gold,
      appBarStyle: FlexAppBarStyle.background,
    );
  }

  static ThemeData getDarkThemeData() {
    return FlexThemeData.dark(
      scheme: FlexScheme.gold,
      appBarStyle: FlexAppBarStyle.background,
    );
  }
}
