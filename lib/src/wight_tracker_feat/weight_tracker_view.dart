import 'package:flutter/material.dart';

class WeightTrackerView extends StatelessWidget {
  const WeightTrackerView({Key? key}) : super(key: key);

  static const routeName = '/weight_tracker';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("weight tracker")),
      body: const Center(child: Text("weight tracker comes here")),
    );
  }
}
