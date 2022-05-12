import 'package:firebase_core/firebase_core.dart';
import 'package:fit_generation/firebase_options.dart';
import 'package:fit_generation/src/app.dart';
import 'package:fit_generation/src/settings_feat/settings_controller.dart';
import 'package:fit_generation/src/settings_feat/settings_service.dart';
import 'package:fit_generation/src/shared_services/shared_prefs_client.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  final sharedPreferences = await SharedPreferences.getInstance();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  runApp(
    /// https://riverpod.dev/docs/getting_started#usage-example-hello-world
    ProviderScope(
      /// https://github.com/csells/go_router/blob/main/go_router/example/lib/state_restoration.dart
      child: const RootRestorationScope(
        restorationId: 'root',
        child: MyApp(),
      ),
      observers: [ProvObserver()],
      overrides: [
        settingsControllerProvider.overrideWithValue(settingsController),
        sharedPrefClientProvider.overrideWithValue(
          SharedPreferencesClient(sharedPreferences),
        ),
      ],
    ),
  );
}

/// https://riverpod.dev/docs/concepts/provider_observer
class ProvObserver extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    debugPrint("provider: ${provider.name ?? provider.runtimeType} "
        "newValue: $newValue");
  }
}
