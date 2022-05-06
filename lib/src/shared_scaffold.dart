import 'package:fit_generation/src/chat_feat/chat_view.dart';
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

  /// The selected index
  final int selectedIndex;

  /// The body of the page. Contains scaffold without navigation bar.
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

  void _tap(BuildContext context, int index) {
    setState(() => _selectedIndex = index);
    switch (index) {
      case 0:
        context.goNamed(SampleItemListView.routeName);
        break;
      case 1:
        context.goNamed(ChatView.routeName);
        break;
      case 2:
        context.goNamed(WeightTrackerView.routeName);
        break;
      default:
        throw Exception("invalid index");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.body,
      bottomNavigationBar: BottomNavigationBar(
        // type: BottomNavigationBarType.shifting,
        // unselectedItemColor: Colors.grey,
        // selectedItemColor: Colors.blue,
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
        onTap: (index) => _tap(context, index),
      ),
    );
  }
}
