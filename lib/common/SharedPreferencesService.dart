import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {

  static final SharedPreferencesService _instance = SharedPreferencesService._internal();

  late SharedPreferences _prefs;

  factory SharedPreferencesService() {
    return _instance;
  }

  SharedPreferencesService._internal();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  SharedPreferences get prefs => _prefs;

  Future<bool> setStringValue(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  String getStringValue(String key, {String defaultValue = ''}) {
    return _prefs.getString(key) ?? defaultValue;
  }

}