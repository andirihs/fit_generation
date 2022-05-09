import 'package:fit_generation/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Return a CancelButtonIcon if route-pop is not possible.
/// Otherwise, return null which will cause the AppBar to show default Icon.
Widget? getCancelWidgetIfPopNotPossible({required BuildContext context}) {
  final canPop = Navigator.of(context).canPop();

  return canPop
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
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        );
}
