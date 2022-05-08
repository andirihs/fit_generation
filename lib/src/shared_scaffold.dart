import 'package:fit_generation/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SharedScaffold extends StatefulWidget {
  const SharedScaffold({
    required this.selectedIndex,
    required this.body,
    Key? key,
  }) : super(key: key);

  /// The selected buttonNavBar-Index
  /// Provide -1 if there should no bottomNavBar be visible
  final int selectedIndex;

  /// The body of the page.
  /// Should contains a Scaffold without navigation bar.
  final Widget body;

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
    context.goNamed(AppRouter.getNamedLocationFromIndex(index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.body,

      /// selected index == -1 => navigation outside of the
      /// bottomNavigationBar stack -> buttonNavigation not visible.
      bottomNavigationBar: _selectedIndex == -1
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
