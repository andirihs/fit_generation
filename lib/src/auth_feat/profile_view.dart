import 'package:fit_generation/src/util_widget/pop_handle_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfileView extends ConsumerWidget {
  const ProfileView({Key? key}) : super(key: key);

  static const String routeName = "profile";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ProfileScreen(
      appBar: AppBar(
        title: const Text('Profile'),
        leading: getCancelWidgetIfPopNotPossible(context: context),
      ),
      children: const [
        Text(
          "!!! Sadly this profile page is not working correctly!!!",
          style: TextStyle(color: Colors.red),
        ),
        // DeleteAccountButton(),
        // SignOutButton(),
      ],
    );
  }
}
