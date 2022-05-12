import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The Provider must be overridden with Pref-Inst. in main() methode
/// as shared prefs must be instantiated async to be able to work sync afterward
final sharedPrefClientProvider = Provider<SharedPreferencesClient>((ref) {
  throw UnimplementedError();
});

class SharedPreferencesClient {
  SharedPreferencesClient(this.sharedPreferences);

  /// SharedPreferences must be initialized async.
  /// Therefore, this instance will be provided after runApp (see main.dart)
  final SharedPreferences sharedPreferences;

  Future<void> setBoolValue({required String key, required bool value}) async {
    await sharedPreferences.setBool(key, value);
  }

  bool? getBoolValue({required String key}) {
    return sharedPreferences.getBool(key);
  }
}
