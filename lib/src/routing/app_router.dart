import 'package:fit_generation/src/chat_feat/chat_view.dart';
import 'package:fit_generation/src/sample_feat/sample_item_details_view.dart';
import 'package:fit_generation/src/sample_feat/sample_item_list_view.dart';
import 'package:fit_generation/src/settings/settings_controller.dart';
import 'package:fit_generation/src/settings/settings_view.dart';
import 'package:fit_generation/src/shared_scaffold.dart';
import 'package:fit_generation/src/wight_tracker_feat/weight_tracker_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  AppRouter({required this.settingsController});

  final SettingsController settingsController;

  GoRouter get router {
    return GoRouter(
      routes: <GoRoute>[
        GoRoute(
          path: "/",
          redirect: (state) =>
              state.namedLocation(SampleItemListView.routeName),
        ),
        GoRoute(
          path: ChatView.routeName,
          name: ChatView.routeName,
          // builder: (context, state) => const ChatView(),
          pageBuilder: (context, state) => NoTransitionPage(
            child: const ChatView(),
            key: state.pageKey,
            restorationId: state.pageKey.value,
          ),
        ),
        GoRoute(
          path: WeightTrackerView.routeName,
          name: WeightTrackerView.routeName,
          // builder: (context, state) => const WeightTrackerView(),
          pageBuilder: (context, state) => NoTransitionPage(
            child: const WeightTrackerView(),
            key: state.pageKey,
            restorationId: state.pageKey.value,
          ),
        ),
        GoRoute(
          path: SampleItemListView.routeName,
          name: SampleItemListView.routeName,
          pageBuilder: (context, state) => NoTransitionPage(
            child: const SampleItemListView(),
            key: state.pageKey,
            restorationId: state.pageKey.value,
          ),
          routes: [
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

      // use the navigatorBuilder to keep the SharedScaffold from being animated
      // as new pages as shown; wrappiong that in single-page Navigator at the
      // root provides an Overlay needed for the adaptive navigation scaffold and
      // a root Navigator to show the About box
      navigatorBuilder: (context, state, child) {
        int getSelectedIndex(String subLoc) {
          switch (subLoc) {
            case SampleItemListView.routeName:
              return 0;
            case ChatView.routeName:
              return 1;
            case WeightTrackerView.routeName:
              return 2;
            default:
              return 0;
          }
        }

        return Navigator(
          /// ToDo: what is this for? See go_router example
          onPopPage: (Route<dynamic> route, dynamic result) {
            route.didPop(result);
            return false; // don't pop the single page on the root navigator
          },
          pages: <Page<dynamic>>[
            NoTransitionPage<void>(
              // child: state.error != null
              //     ? ErrorScaffold(body: child)
              //     : SharedScaffold(
              child: SharedScaffold(
                selectedIndex: getSelectedIndex(state.subloc),
                body: child,
              ),
            ),
          ],
        );
      },
    );
  }
}
