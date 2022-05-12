import 'package:fit_generation/src/shared_services/shared_prefs_client.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final sharedPrefServiceProvider = Provider<SharedPreferencesService>((ref) {
  return SharedPreferencesService(ref.read);
});

class SharedPreferencesService {
  SharedPreferencesService(this._read);

  final Reader _read;
  late final _sharePrefsClient = _read(sharedPrefClientProvider);

  static const isOnboardingCompleteKey = "isOnboardingComplete";

  Future<void> setOnboardingDone() async {
    await _sharePrefsClient.setBoolValue(
        key: isOnboardingCompleteKey, value: true);
  }

  bool isOnboardingDone() {
    return _sharePrefsClient.getBoolValue(key: isOnboardingCompleteKey) ??
        false;
  }
}
