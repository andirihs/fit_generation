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

  static const homeRoute = 'home';
  int _lastIndex = 0;

  /// provide namedLocation for every top-view (which is visible in NavBar)
  /// Must match the order of the NavBarItems
  static String getNamedLocationFromIndex(int index) {
    switch (index) {
      case 0:
        return SampleItemListView.routeName;
      case 1:
        return ChatView.routeName;
      case 2:
        return WeightTrackerView.routeName;
      default:
        throw Exception("invalid index");
    }
  }

  /// Get the BottomNavBar-Index related to the namedLocation.
  ///
  /// Return -1 if the route is not part on the bottomNavBar.
  /// The order must match with the buttonNavBarItems in SharedScaffold.
  int getSelectedNavBarIndex(String navigationLocation) {
    int bottomNavIndex = -1;
    if (navigationLocation.contains(SampleItemListView.routeName)) {
      bottomNavIndex = 0;
    } else if (navigationLocation.contains(ChatView.routeName)) {
      bottomNavIndex = 1;
    } else if (navigationLocation.contains(WeightTrackerView.routeName)) {
      bottomNavIndex = 2;
    }

    /// Store the index to be able to return to the last ButtonNavBarScreen,
    /// only if the last index pointing to an existing NavBarIndex
    if (bottomNavIndex >= 0) {
      _lastIndex = bottomNavIndex;
    }
    return bottomNavIndex;
  }

  GoRouter get router {
    return GoRouter(
      routes: <GoRoute>[
        GoRoute(
          path: "/",
          name: homeRoute,
          redirect: (state) {
            final namedLocation = getNamedLocationFromIndex(_lastIndex);
            return state.namedLocation(namedLocation);
          },
        ),
        GoRoute(
          path: "/" + ChatView.routeName,
          name: ChatView.routeName,
          // builder: (context, state) => const ChatView(),
          pageBuilder: (context, state) => NoTransitionPage(
            child: const ChatView(),
            key: state.pageKey,
            restorationId: state.pageKey.value,
          ),
        ),
        GoRoute(
          path: "/" + WeightTrackerView.routeName,
          name: WeightTrackerView.routeName,
          // builder: (context, state) => const WeightTrackerView(),
          pageBuilder: (context, state) => NoTransitionPage(
            child: const WeightTrackerView(),
            key: state.pageKey,
            restorationId: state.pageKey.value,
          ),
        ),
        GoRoute(
          path: "/" + SampleItemListView.routeName,
          name: SampleItemListView.routeName,
          pageBuilder: (context, state) => NoTransitionPage(
            child: const SampleItemListView(),
            key: state.pageKey,
            restorationId: state.pageKey.value,
          ),
          routes: [
            GoRoute(
              path: SampleItemDetailsView.routeName + ":id",
              name: SampleItemDetailsView.routeName,
              builder: (context, state) {
                final id = state.params["id"];
                return SampleItemDetailsView(id: int.parse(id!));
              },
            ),
          ],
        ),
        GoRoute(
          path: "/" + SettingsView.routeName,
          name: SettingsView.routeName,
          builder: (context, state) => SettingsView(
            controller: settingsController,
          ),
        ),
      ],
      restorationScopeId: 'router',
      debugLogDiagnostics: true,

      // use the navigatorBuilder to keep the SharedScaffold from being animated
      // as new pages as shown; wrapping that in single-page Navigator at the
      // root provides an Overlay needed for the SharedScaffold.
      navigatorBuilder: (context, state, child) {
        final navBarIndex = getSelectedNavBarIndex(state.location);

        return Navigator(
          /// ToDo: what is this for?
          /// See go_router example: https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/shared_scaffold.dart
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
                selectedIndex: navBarIndex,
                body: child,
              ),
              restorationId: state.pageKey.value,
            ),
          ],
        );
      },
    );
  }
}
