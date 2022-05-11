import 'package:firebase_core/firebase_core.dart';
import 'package:fit_generation/firebase_options.dart';
import 'package:fit_generation/src/app.dart';
import 'package:fit_generation/src/chat_feat/chat_repo.dart';
import 'package:fit_generation/src/settings/settings_controller.dart';
import 'package:fit_generation/src/settings/settings_service.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final streamChatClient = StreamChatClient(
    'cb2e82d3hkf8',
    logLevel: Level.INFO,
  );

  // final steamChatModel = await ChatRepo.initSteamChat();

  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  runApp(
    /// https://riverpod.dev/docs/getting_started#usage-example-hello-world
    ProviderScope(
      /// https://github.com/csells/go_router/blob/main/go_router/example/lib/state_restoration.dart
      child: RootRestorationScope(
        restorationId: 'root',
        child: MyApp(
          settingsController: settingsController,
          // chatClient: steamChatModel.client,
          chatClient: streamChatClient,
        ),
      ),
      observers: [ProvObserver()],
      overrides: [streamChatClientProvider.overrideWithValue(streamChatClient)],
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
