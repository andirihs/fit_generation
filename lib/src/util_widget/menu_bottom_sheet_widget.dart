import 'package:fit_generation/src/auth_feat/profile_view.dart';
import 'package:fit_generation/src/localization/i10n.dart';
import 'package:fit_generation/src/settings_feat/settings_view.dart';
import 'package:fit_generation/src/weight_tracker_feat/weight_tracker_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MenuBottomSheetWidget extends ConsumerWidget {
  const MenuBottomSheetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MenuListTileWidget(
            title: context.l10n.navMenuWeightTracker,
            icon: Icons.monitor_weight,
            namedRoute: WeightTrackerView.routeName,
          ),
          MenuListTileWidget(
            title: context.l10n.navMenuProfile,
            icon: Icons.person,
            namedRoute: ProfileView.routeName,
          ),
          MenuListTileWidget(
            title: context.l10n.navMenuSetting,
            icon: Icons.settings,
            namedRoute: SettingsView.routeName,
          ),
        ],
      ),
    );
  }
}

class MenuListTileWidget extends ConsumerWidget {
  const MenuListTileWidget(
      {required this.title,
      required this.icon,
      required this.namedRoute,
      Key? key})
      : super(key: key);

  final String title;
  final IconData icon;
  final String namedRoute;

  void _onTap(BuildContext context) {
    /// close the navBar before navigating
    Navigator.pop(context);
    context.pushNamed(namedRoute);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      onTap: () => _onTap(context),
    );
  }
}
