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

    return bottomNavIndex;
  }

  GoRouter get router {
    return GoRouter(
      routes: <GoRoute>[
        GoRoute(
          path: "/",
          name: homeRoute,
          redirect: (state) {
            // final namedLocation = getNamedLocationFromIndex(_lastIndex);
            // return state.namedLocation(SampleItemListView.routeName);
            return "/" + SampleItemListView.routeName;
          },
        ),
        GoRoute(
          path: "/:navBarName",
          name: SharedScaffold.routeName,
          builder: (context, state) {
            final index = getSelectedNavBarIndex(state.params["navBarName"]!);

            return SharedScaffold(
              /// provide null for main SharedScaffold
              body: null,
              selectedIndex: index,
              key: state.pageKey,
            );
          },
          routes: [
            GoRoute(
              path: SampleItemDetailsView.routeName + "/:id",
              name: SampleItemDetailsView.routeName,
              builder: (context, state) {
                final id = state.params["id"];
                return SampleItemDetailsView(id: int.parse(id!));
              },
            ),
            GoRoute(
              path: SettingsView.routeName,
              name: SettingsView.routeName,
              builder: (context, state) => SettingsView(
                controller: settingsController,
              ),
            ),
          ],
        ),
      ],
      restorationScopeId: 'router',
      debugLogDiagnostics: true,

      /// Use the navigatorBuilder to keep the SharedScaffold from being animated
      /// as new pages as shown; wrapping that in single-page Navigator at the
      /// root provides an Overlay needed for the SharedScaffold.
      ///
      /// Remove this, if you don't want to have buttonNavBar for subpages
      navigatorBuilder: (context, state, child) {
        final navBarIndex = getSelectedNavBarIndex(state.location);

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
