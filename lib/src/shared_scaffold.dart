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

  final _pageController = PageController();

  @override
  void didUpdateWidget(SharedScaffold oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() => _selectedIndex = widget.selectedIndex);
  }

  /// Rebuild the BottomNavBar and navigate to the corresponding view/route.
  void tap(BuildContext context, int index) {
    setState(() => _selectedIndex = index);
    _pageController.jumpToPage(index);
    context.goNamed(AppRouter.getNamedLocationFromIndex(index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: widget.body
      /// https://pub.dev/packages/bottom_navy_bar
      body: SizedBox.expand(
        child: PageView(
          onPageChanged: (index) => setState(() => _selectedIndex = index),

          /// must match the order of the button nav items and router methods.
          children: const [
            SampleItemListView(),
            ChatView(),
            WeightTrackerView(),
          ],
          controller: _pageController,
        ),
      ),

      /// https://pub.dev/packages/bubble_bottom_bar
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,

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
    //       : BubbleBottomBar(
    //           currentIndex: _selectedIndex,
    //           backgroundColor: Colors.white,
    //           fabLocation: BubbleBottomBarFabLocation.end,
    //           items: const [
    //             BubbleBottomBarItem(
    //               icon: Icon(Icons.list),
    //               activeIcon: Icon(Icons.list),
    //               title: Text('sample list'),
    //               backgroundColor: Colors.grey,
    //             ),
    //             BubbleBottomBarItem(
    //               icon: Icon(Icons.chat),
    //               activeIcon: Icon(Icons.chat),
    //               title: Text('chat'),
    //               backgroundColor: Colors.grey,
    //             ),
    //             BubbleBottomBarItem(
    //               icon: Icon(Icons.monitor_weight),
    //               activeIcon: Icon(Icons.monitor_weight),
    //               title: Text('weight tracker'),
    //               backgroundColor: Colors.grey,
    //             ),
    //           ],
    //           onTap: (index) => tap(context, index!),
    //           // onTab: (index) => tap(context, index),
    //           opacity: 1,
    //         ),
    // );
  }
}
