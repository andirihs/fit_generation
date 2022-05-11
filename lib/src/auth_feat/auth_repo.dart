import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authRepoProvider = Provider<IAuthRepo>((ref) {
  return FirebaseAuthRepo();
});

abstract class IAuthRepo {
  Stream<String?> authStageChanges();

  String? currentUserId();

  String? currentUserEmail();

  bool isUserLoggedIn();
}

/// Used for Firebase-UI.
final emailLinkProviderConfig = EmailLinkProviderConfiguration(
  actionCodeSettings: ActionCodeSettings(
    url: 'https://fitgenerationapp.page.link',
    handleCodeInApp: true,
    androidMinimumVersion: '1',
    androidPackageName: 'app.fitgeneration.fit_generation',
    iOSBundleId: 'app.fitgeneration.fitGeneration',
    androidInstallApp: true,
  ),

  /// dynamicLinks: is set automatically and must not be set manually.
);

class FirebaseAuthRepo implements IAuthRepo {
  final _authInst = FirebaseAuth.instance;

  @override
  Stream<String?> authStageChanges() {
    return _authInst.authStateChanges().map((event) {
      debugPrint("currentUser: $event");

      return event?.uid;
    });
  }

  @override
  bool isUserLoggedIn() {
    return _authInst.currentUser == null ? false : true;
  }

  @override
  String? currentUserId() {
    return _authInst.currentUser?.uid;
  }

  @override
  String? currentUserEmail() {
    return _authInst.currentUser?.email;
  }
}
