import 'package:fit_generation/src/auth_feat/profile_view.dart';
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

  static const routeName = 'sample_list';

  final List<SampleItem> items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Items'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),

            /// push will give a return button
            onPressed: () => context.pushNamed(SettingsView.routeName),

            /// go will give a cancel button
            // onPressed: () => context.goNamed(SettingsView.routeName),
          ),
          IconButton(
            icon: const Icon(Icons.person),

            /// push will give a return button
            onPressed: () => context.pushNamed(ProfileView.routeName),

            /// go will give a cancel button
            // onPressed: () => context.goNamed(ProfileView.routeName),
          ),
        ],
      ),
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
              SampleItemDetailsView.routeName,
              params: {"id": "${item.id}"},
            ),
          );
        },
      ),
    );
  }
}
