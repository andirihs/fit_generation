import 'package:fit_generation/src/auth_feat/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthView extends ConsumerWidget {
  const AuthView({Key? key}) : super(key: key);

  static const String routeName = "login";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// EmailLinkSignInScreen has a EmailLinkSignInView inside which contain
    /// an AuthFlowBuilder which takes an EmailLinkProviderConfiguration.
    /// This email provider configuration must be provided.
    ///
    /// This EmailLinkProviderConfiguration will also be included  in
    /// FirebaseDynamicLink instance to read incoming deep-links.
    /// No need to read dynamic links manually.
    return EmailLinkSignInScreen(
      /// actions: not needed as we navigate with a refreshListener!
      config: emailLinkProviderConfig,
      headerBuilder: headerIcon(Icons.link),
      sideBuilder: sideIcon(Icons.link),
    );
  }
}

HeaderBuilder headerIcon(IconData icon) {
  return (context, constraints, shrinkOffset) {
    return Padding(
      padding: const EdgeInsets.all(20).copyWith(top: 40),
      child: Icon(
        icon,
        size: constraints.maxWidth / 4 * (1 - shrinkOffset),
      ),
    );
  };
}

// HeaderBuilder headerImage(String assetName) {
//   return (context, constraints, _) {
//     return Padding(
//       padding: const EdgeInsets.all(20),
//       child: Image.asset(assetName),
//     );
//   };
// }

SideBuilder sideIcon(IconData icon) {
  return (context, constraints) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Icon(
        icon,
        size: constraints.maxWidth / 3,
      ),
    );
  };
}

// SideBuilder sideImage(String assetName) {
//   return (context, constraints) {
//     return Center(
//       child: Padding(
//         padding: EdgeInsets.all(constraints.maxWidth / 4),
//         child: Image.asset(assetName),
//       ),
//     );
//   };
// }
