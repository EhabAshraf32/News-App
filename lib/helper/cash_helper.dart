// ignore_for_file: unused_local_variable

import 'package:shared_preferences/shared_preferences.dart';

class CashHelper {
  static SharedPreferences? prefs;
  static init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> putData({
    required var key,
    required var value,
  }) async {
    return await prefs!.setBool(key, value);
  }

  static bool? getData({
    required var key,
  }) {
    return prefs!.getBool(key);
  }
}
