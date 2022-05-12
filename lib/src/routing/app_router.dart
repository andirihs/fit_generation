import 'package:fit_generation/src/auth_feat/auth_repo.dart';
import 'package:fit_generation/src/auth_feat/auth_view.dart';
import 'package:fit_generation/src/auth_feat/onboarding_view.dart';
import 'package:fit_generation/src/auth_feat/profile_view.dart';
import 'package:fit_generation/src/chat_feat/channel_list_view.dart';
import 'package:fit_generation/src/chat_feat/chat_view.dart';
import 'package:fit_generation/src/grocery_list_feat/grocery_item_details_view.dart';
import 'package:fit_generation/src/grocery_list_feat/grocery_item_list_view.dart';
import 'package:fit_generation/src/overview_feat/overview_view.dart';
import 'package:fit_generation/src/settings_feat/settings_controller.dart';
import 'package:fit_generation/src/settings_feat/settings_view.dart';
import 'package:fit_generation/src/shared_scaffold.dart';
import 'package:fit_generation/src/shared_services/shared_prefs_service.dart';
import 'package:fit_generation/src/weight_tracker_feat/weight_tracker_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppRouter {
  AppRouter({required this.settingsController, required this.reader});

  final SettingsController settingsController;
  final Reader reader;

  static const homeRoute = 'home';
  int _lastIndex = 0;

  /// provide namedLocation for every top-view (which is visible in NavBar)
  /// Must match the order of the NavBarItems
  static String getNamedLocationFromIndex(int index) {
    switch (index) {
      case 0:
        return OverviewView.routeName;
      case 1:
        return ChannelView.routeName;
      case 2:
        return GroceryListView.routeName;
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
    if (navigationLocation.contains(OverviewView.routeName)) {
      bottomNavIndex = 0;
    } else if (navigationLocation.contains(ChannelView.routeName)) {
      bottomNavIndex = 1;
    } else if (navigationLocation.contains(GroceryListView.routeName)) {
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
          path: "/" + OverviewView.routeName,
          name: OverviewView.routeName,
          pageBuilder: (context, state) => NoTransitionPage(
            child: const OverviewView(),
            key: state.pageKey,
            restorationId: state.pageKey.value,
          ),
        ),
        GoRoute(
          path: "/" + ChannelView.routeName,
          name: ChannelView.routeName,
          pageBuilder: (context, state) => NoTransitionPage(
            child: const ChannelView(),
            key: state.pageKey,
            restorationId: state.pageKey.value,
          ),
          routes: [
            GoRoute(
              path: ChatView.routeName,
              name: ChatView.routeName,
              builder: (_, __) => const ChatView(),
            ),
          ],
        ),
        GoRoute(
          path: "/" + GroceryListView.routeName,
          name: GroceryListView.routeName,
          pageBuilder: (context, state) => NoTransitionPage(
            child: const GroceryListView(),
            key: state.pageKey,
            restorationId: state.pageKey.value,
          ),
          routes: [
            GoRoute(
              path: GroceryItemDetailsView.routeName + ":id",
              name: GroceryItemDetailsView.routeName,
              builder: (context, state) {
                final id = state.params["id"];
                return GroceryItemDetailsView(id: int.parse(id!));
              },
            ),
          ],
        ),
        GoRoute(
          path: "/" + SettingsView.routeName,
          name: SettingsView.routeName,
          builder: (_, __) => SettingsView(),
        ),
        GoRoute(
          path: "/" + AuthView.routeName,
          name: AuthView.routeName,
          builder: (_, __) => const AuthView(),
        ),
        GoRoute(
          path: "/" + ProfileView.routeName,
          name: ProfileView.routeName,
          builder: (_, __) => const ProfileView(),
        ),
        GoRoute(
          path: "/" + OnboardingView.routeName,
          name: OnboardingView.routeName,
          builder: (_, __) {
            return const OnboardingView();
          },
        ),
        GoRoute(
          path: "/" + WeightTrackerView.routeName,
          name: WeightTrackerView.routeName,
          builder: (_, __) {
            return WeightTrackerView();
          },
        ),
      ],
      restorationScopeId: 'router',
      debugLogDiagnostics: true,

      /// Changes on the listenable will cause the router to refresh it's route
      refreshListenable: GoRouterRefreshStream(
        reader(authRepoProvider).authStageChanges(),
      ),

      redirect: (state) {
        final isOnboardingDone =
            reader(sharedPrefServiceProvider).isOnboardingDone();
        final isUserSignedIn = reader(authRepoProvider).isUserLoggedIn();
        final signingIn = state.subloc == "/" + AuthView.routeName;

        final toOnboarding = state.subloc.contains(OnboardingView.routeName);
        if (!isOnboardingDone && !toOnboarding) {
          return state.namedLocation(OnboardingView.routeName);
        } else if (!isOnboardingDone && toOnboarding) {
          return null;
        }

        /// Go to /login if the user is not signed in
        if (!isUserSignedIn && !signingIn) {
          return state.namedLocation(AuthView.routeName);
        }

        if (isUserSignedIn && signingIn) {
          return state.namedLocation(GroceryListView.routeName);
        }

        /// return null => no redirect
        return null;
      },

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
