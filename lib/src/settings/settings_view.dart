import 'package:fit_generation/src/routing/app_router.dart';
import 'package:fit_generation/src/settings/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Displays the various settings that can be customized by the user.
///
/// When a user changes a setting, the SettingsController is updated and
/// Widgets that listen to the SettingsController are rebuilt.
class SettingsView extends StatelessWidget {
  const SettingsView({required this.controller, Key? key}) : super(key: key);

  static const routeName = 'settings';

  final SettingsController controller;

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.of(context).canPop();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: canPop
            ? null
            : IconButton(
                icon: Icon(
                  Icons.close,
                  color: Theme.of(context).colorScheme.error,
                ),
                onPressed: () {
                  /// queryParam could be added to navigate back to correct path
                  context.goNamed(AppRouter.homeRoute);
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        // Glue the SettingsController to the theme selection DropdownButton.
        //
        // When a user selects a theme from the dropdown list, the
        // SettingsController is updated, which rebuilds the MaterialApp.
        child: DropdownButton<ThemeMode>(
          // Read the selected themeMode from the controller
          value: controller.themeMode,
          // Call the updateThemeMode method any time the user selects a theme.
          onChanged: controller.updateThemeMode,
          items: const [
            DropdownMenuItem(
              value: ThemeMode.system,
              child: Text('System Theme'),
            ),
            DropdownMenuItem(
              value: ThemeMode.light,
              child: Text('Light Theme'),
            ),
            DropdownMenuItem(
              value: ThemeMode.dark,
              child: Text('Dark Theme'),
            )
          ],
        ),
      ),
    );
  }
}
