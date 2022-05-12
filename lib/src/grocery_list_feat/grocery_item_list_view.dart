import 'package:fit_generation/src/grocery_list_feat/grocery_item_details_view.dart';
import 'package:fit_generation/src/grocery_list_feat/grocery_item_model.dart';
import 'package:fit_generation/src/util_widget/custom_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Displays a list of SampleItems.
class GroceryListView extends StatelessWidget {
  const GroceryListView({
    Key? key,
    this.items = const [
      SampleItem(1),
      SampleItem(2),
      SampleItem(3),
      SampleItem(4),
      SampleItem(5),
      SampleItem(6),
      SampleItem(7),
      SampleItem(8),
      SampleItem(9),
      SampleItem(10),
      SampleItem(12),
      SampleItem(13),
      SampleItem(14),
      SampleItem(15),
      SampleItem(16),
      SampleItem(17),
      SampleItem(18),
      SampleItem(19),
      SampleItem(20),
      SampleItem(21),
    ],
  }) : super(key: key);

  static const routeName = 'grocery_list';

  final List<SampleItem> items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: routeName),
      body: ListView.builder(
        /// Providing a restorationId allows the ListView to restore the
        /// scroll position when a user leaves and returns to the app after it
        /// has been killed while running in the background.
        // ToDo: not working
        restorationId: 'sampleItemListView',
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          final item = items[index];

          return ListTile(
            title: Text('SampleItem ${item.id}'),
            leading: const CircleAvatar(
              foregroundImage:
                  AssetImage('assets/logo/Logo_Fit-Generation.png'),
            ),
            onTap: () => context.goNamed(
              GroceryItemDetailsView.routeName,
              params: {"id": "${item.id}"},
            ),
          );
        },
      ),
    );
  }
}
