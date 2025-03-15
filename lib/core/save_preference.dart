import 'package:shared_preferences/shared_preferences.dart';

class SavePreferences {
  static SharedPreferences? _prefs;
  static Future<SharedPreferences> get _instance async =>
      _prefs ??= await SharedPreferences.getInstance();

  static Future<SharedPreferences> init() async {
    _prefs = await _instance;
    return _prefs!;
  }

  static Future<void> saveIntPreferences(String key, int value) async {
    await _prefs!.setInt(key, value);
  }

  static int? getIntPreferences(String key) {
    return _prefs!.getInt(key);
  }

  static Future<void> saveBoolPreferences(String key, bool value) async {
    await _prefs!.setBool(key, value);
  }

  static bool? getBoolPreferences(String key) {
    return _prefs!.getBool(key);
  }

  static Future<void> saveStringPreferences(String key, String value) async {
    await _prefs!.setString(key, value);
  }

  static String? getStringPreferences(String key) {
    return _prefs!.getString(key);
  }

  static Future clearAKey(String key) {
    return _prefs!.remove(key);
  }

  static Future<void> clearSharedPreferences() async {
    await _prefs!.clear();
  }

  static Future<bool> clearAll() async {
    final bool isCleared = await _prefs!.clear();
    return isCleared;
  }
}
