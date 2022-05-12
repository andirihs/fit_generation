import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension LocalizedBuildContext on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}

/// https://docs.flutter.dev/development/accessibility-and-localization/internationalization#how-internationalization-in-flutter-works
extension MaterialLocalizedBuildContext on BuildContext {
  MaterialLocalizations get l10nMat => MaterialLocalizations.of(this);
}
