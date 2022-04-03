import 'package:shared_preferences/shared_preferences.dart';

class CacheManager implements AbsCacheManager {
  static SharedPreferences? _preferences;

  @override
  Future init() async {
    if (_preferences != null) return;
    _preferences = await SharedPreferences.getInstance();
  }

  @override
  Future storeString(String key, String value) async {
    await _preferences!.setString(key, value);
  }

  @override
  Future storeBool(String key, bool value) async {
    await _preferences!.setBool(key, value);
  }

  @override
  String? retrieveString(String key) {
    return _preferences!.getString(key);
  }

  @override
  bool? retrieveBool(String key) {
    return _preferences!.getBool(key);
  }

  @override
  Future remove(String key) async {
    await _preferences!.remove(key);
  }

  @override
  bool keyExists(String key) {
    return _preferences!.containsKey(key);
  }

  @override
  Future<void> clearAll() async {
    await _preferences!.clear();
  }
}

abstract class AbsCacheManager {
  Future<void> init();

  Future<void> storeString(String key, String value);

  Future<void> storeBool(String key, bool value);

  String? retrieveString(String key);

  bool? retrieveBool(String key);

  Future<void> remove(String key);

  Future<void> clearAll();

  bool keyExists(String key);
}
