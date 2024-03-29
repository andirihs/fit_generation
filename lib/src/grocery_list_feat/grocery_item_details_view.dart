import 'package:flutter/material.dart';

/// Displays detailed information about a SampleItem.
class GroceryItemDetailsView extends StatelessWidget {
  const GroceryItemDetailsView({Key? key, required this.id}) : super(key: key);

  final int id;

  static const routeName = 'grocery_item';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item Details of Item $id'),
      ),
      body: Center(
        child: Text('More Information Here regarding item #$id'),
      ),
    );
  }
}
