import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String _userNameKey = 'user_name';

  static Future<String?> getUserName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userNameKey);
  }

  static Future<void> saveUserName(String userName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userNameKey, userName);
  }

  static Future<void> clearUserName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userNameKey);
  }
}
