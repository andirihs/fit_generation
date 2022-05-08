import 'package:fit_generation/src/chat_feat/chat_view.dart';
import 'package:fit_generation/src/routing/app_router.dart';
import 'package:fit_generation/src/sample_feat/sample_item_list_view.dart';
import 'package:fit_generation/src/wight_tracker_feat/weight_tracker_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SharedScaffold extends StatefulWidget {
  const SharedScaffold({
    required this.selectedIndex,
    required this.body,
    Key? key,
  }) : super(key: key);

  static const String routeName = "app";

  /// The selected buttonNavBar-Index
  /// Provide -1 if there should no bottomNavBar be visible
  final int selectedIndex;

  /// Used body to provide a body for the SharedScaffold.
  /// This body should contain another Scaffold.
  ///
  /// Don't provide a body if you want to navigate to top-pages.
  final Widget? body;

  @override
  State<SharedScaffold> createState() => _SharedScaffoldState();
}

class _SharedScaffoldState extends State<SharedScaffold> {
  int _selectedIndex = 0;

  @override
  void didUpdateWidget(SharedScaffold oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() => _selectedIndex = widget.selectedIndex);
  }

  /// Rebuild the BottomNavBar and navigate to the corresponding view/route.
  void tap(BuildContext context, int index) {
    setState(() => _selectedIndex = index);
    context.go("/" + AppRouter.getNamedLocationFromIndex(index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// According to: https://github.com/bizz84/nested-navigation-demo-flutter
      /// Order of the screens must match with with the items in BottomNavBar
      /// and the methods in router.
      body: widget.body ??
          Stack(
            children: [
              Offstage(
                child: const SampleItemListView(),
                offstage: _selectedIndex != 0,
              ),
              Offstage(
                child: const ChatView(),
                offstage: _selectedIndex != 1,
              ),
              Offstage(
                child: const WeightTrackerView(),
                offstage: _selectedIndex != 2,
              ),
            ],
          ),
      bottomNavigationBar: widget.body == null
          ? null
          : BottomNavigationBar(
              currentIndex: _selectedIndex,
              mouseCursor: SystemMouseCursors.grab,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.list),
                  label: "sample list",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.chat),
                  label: "chat",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.monitor_weight),
                  label: "weight tracker",
                ),
              ],
              onTap: (index) => tap(context, index),
            ),
    );
  }
}
