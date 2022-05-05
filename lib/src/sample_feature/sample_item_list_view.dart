import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../settings/settings_view.dart';
import 'sample_item.dart';
import 'sample_item_details_view.dart';

/// Displays a list of SampleItems.
class SampleItemListView extends StatelessWidget {
  const SampleItemListView({
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

  static const routeName = '/';

  final List<SampleItem> items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Items'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to the settings page. If the user leaves and returns
              // to the app after it has been killed while running in the
              // background, the navigation stack is restored.
              // Navigator.restorablePushNamed(context, SettingsView.routeName);
              // context.go("/" + SettingsView.routeName);
              context.goNamed(SettingsView.routeName);
            },
          ),
        ],
      ),
      body: ListView.builder(
        // Providing a restorationId allows the ListView to restore the
        // scroll position when a user leaves and returns to the app after it
        // has been killed while running in the background.
        restorationId: 'sampleItemListView',
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          final item = items[index];

          return ListTile(
            title: Text('SampleItem ${item.id}'),
            leading: const CircleAvatar(
              // Display the Flutter Logo image asset.
              foregroundImage:
                  AssetImage('assets/logo/Logo_Fit-Generation.png'),
            ),
            onTap: () {
              // Navigate to the details page. If the user leaves and returns to
              // the app after it has been killed while running in the
              // background, the navigation stack is restored.
              // Navigator.restorablePushNamed(
              //     context, SampleItemDetailsView.routeName);
              // context.go("/" + SampleItemDetailsView.routeName);
              context.goNamed(SampleItemDetailsView.routeName);
            },
          );
        },
      ),
    );
  }
}
