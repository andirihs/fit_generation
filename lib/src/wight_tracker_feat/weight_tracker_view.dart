import 'package:fit_generation/src/settings/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WeightTrackerView extends StatelessWidget {
  const WeightTrackerView({Key? key}) : super(key: key);

  static const routeName = 'weight_tracker';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("weight tracker")),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              child: const Text("push to settings"),
              onPressed: () => context.pushNamed(SettingsView.routeName),
            ),
            ElevatedButton(
              child: const Text("go to settings"),
              onPressed: () => context.goNamed(SettingsView.routeName),
            ),
          ],
        ),
      ),
    );
  }
}
