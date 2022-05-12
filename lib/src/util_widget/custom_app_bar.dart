import 'package:fit_generation/src/auth_feat/profile_view.dart';
import 'package:fit_generation/src/localization/i10n.dart';
import 'package:fit_generation/src/settings_feat/settings_view.dart';
import 'package:fit_generation/src/wight_tracker_feat/weight_tracker_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    required this.title,
    this.actions,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.useRoundedEdges = false,
    Key? key,
  }) : super(key: key);

  /// Title which will be displayed in the AppBar
  final String title;

  /// Typically these widgets are [IconButton]s representing common operations.
  /// For less common operations, consider using a [PopupMenuButton] as the
  /// last action.
  final List<Widget>? actions;

  /// Typically the [leading] widget is an [Icon] or an [IconButton].
  ///
  /// If this is null and [automaticallyImplyLeading] is set to true, the
  /// [AppBar] will imply an appropriate widget. For example, if the [AppBar] is
  /// in a [Scaffold] that also has a [Drawer], the [Scaffold] will fill this
  /// widget with an [IconButton] that opens the drawer (using [Icons.menu]). If
  /// there's no [Drawer] and the parent [Navigator] can go back, the [AppBar]
  /// will use a [BackButton] that calls [Navigator.maybePop].
  final Widget? leading;

  /// If true and [leading] is null, automatically deduce the leading widget
  /// If false and [leading] is null, leading space is given to [title].
  final bool automaticallyImplyLeading;

  /// Use rounded edges at the bottom at the AppBar
  /// Default to false
  /// If rounded Edges are true, then ``useWave`` is ignored.
  final bool useRoundedEdges;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500),
        maxLines: 1,
      ),
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
      shape: useRoundedEdges
          ? const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            )
          : null,
      actions: [
        ...?actions,
        const Padding(
          padding: EdgeInsets.all(10 / 1.5),
          child: MenuIconButton(),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class MenuIconButton extends ConsumerWidget {
  const MenuIconButton({Key? key}) : super(key: key);

  void _onTap(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      builder: (context) => const MenuBottomSheetWidget(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () => _onTap(context),
      icon: const Icon(Icons.menu),
    );
  }
}

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
    context.goNamed(namedRoute);
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
