import 'package:fit_generation/src/app_theming.dart';
import 'package:fit_generation/src/chat_feat/chat_repo.dart';
import 'package:fit_generation/src/routing/app_router.dart';
import 'package:fit_generation/src/settings_feat/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

/// The Widget that configures your application.
class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

/// RestorationMixin -> https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/state_restoration.dart
class _MyAppState extends ConsumerState<MyApp> with RestorationMixin {
  @override
  String get restorationId => 'wrapper';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    /// For Bottom Nav Bar: https://dev.to/pedromassango/what-is-state-restoration-and-how-to-use-it-in-flutter-5blm
    // todo: implement restoreState for you app
  }

  late final _settingsController = ref.watch(settingsControllerProvider);

  late final _router = AppRouter(
    settingsController: _settingsController,
    reader: ref.read,
  ).router;

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The AnimatedBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return AnimatedBuilder(
      animation: _settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp.router(
          // Providing a restorationScopeId allows the Navigator built by the
          // MaterialApp to restore the navigation stack when a user leaves and
          // returns to the app after it has been killed while running in the
          // background.
          restorationScopeId: 'app',

          // Provide the generated AppLocalizations to the MaterialApp. This
          // allows descendant Widgets to display the correct translations
          // depending on the user's locale.
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English, no country code
          ],

          // Use AppLocalizations to configure the correct application title
          // depending on the user's locale.
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,

          // Define a light and dark color theme. Then, read the user's
          // preferred ThemeMode (light, dark, or system default) from the
          // SettingsController to display the correct theme.
          theme: AppTheme.getLightThemeData(),
          darkTheme: AppTheme.getDarkThemeData(),
          themeMode: _settingsController.themeMode,
          routerDelegate: _router.routerDelegate,
          routeInformationParser: _router.routeInformationParser,
          builder: (context, child) {
            /// Provide stream chat to inherited widget!!
            return StreamChat(
              child: child,
              client: ref.watch(streamChatClientProvider),
            );
          },
        );
      },
    );
  }
}
