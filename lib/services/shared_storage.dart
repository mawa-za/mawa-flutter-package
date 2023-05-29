part of 'package:mawa_package/mawa_package.dart';

class SharedStorage{

  static void setString({required String key,required String detail}) async {
    final SharedPreferences prefs = await preferences;
    prefs.setString(key, detail);
  }

  static Future<String?> getString(String keyDetail) async {
    final SharedPreferences prefs = await preferences;
    return prefs.getString(keyDetail);
  }

  static void setbool({required String key,required bool detail}) async {
    final SharedPreferences prefs = await preferences;
    prefs.setBool(key, detail);
  }

  static Future<bool?> geBool(String keyDetail) async {
    final SharedPreferences prefs = await preferences;
    return prefs.getBool(keyDetail);
  }

  static void setDouble({required String key,required double detail}) async {
    final SharedPreferences prefs = await preferences;
    prefs.setDouble(key, detail);
  }

  static Future<double?> geDouble(String keyDetail) async {
    final SharedPreferences prefs = await preferences;
    return prefs.getDouble(keyDetail);
  }

  static void setStringList({required String key,required List<String> detail}) async {
    final SharedPreferences prefs = await preferences;
    prefs.setStringList(key, detail);
  }

  static Future<List<String>?> getStringList(String keyDetail) async {
    final SharedPreferences prefs = await preferences;
    return prefs.getStringList(keyDetail);
  }

}