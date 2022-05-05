import 'package:fit_generation/src/sample_feature/sample_item_details_view.dart';
import 'package:fit_generation/src/sample_feature/sample_item_list_view.dart';
import 'package:fit_generation/src/settings/settings_controller.dart';
import 'package:fit_generation/src/settings/settings_view.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  AppRouter({required this.settingsController});

  final SettingsController settingsController;

  GoRouter get router {
    return GoRouter(
      routes: <GoRoute>[
        GoRoute(
          path: SampleItemListView.routeName,
          name: SampleItemListView.routeName,
          builder: (context, state) => const SampleItemListView(),
          routes: <GoRoute>[
            GoRoute(
              path: SettingsView.routeName,
              name: SettingsView.routeName,
              builder: (context, state) => SettingsView(
                controller: settingsController,
              ),
            ),
            GoRoute(
              path: SampleItemDetailsView.routeName,
              name: SampleItemDetailsView.routeName,
              builder: (context, state) => const SampleItemDetailsView(),
            ),
          ],
        ),
      ],
      restorationScopeId: 'router',
      debugLogDiagnostics: true,
    );
  }
}
