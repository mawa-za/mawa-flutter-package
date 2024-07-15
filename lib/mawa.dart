part of 'package:mawa_package/mawa_package.dart';

class Mawa{
  final String server;
  final String loginScreenID;
  String? initialScreenID, tenantID;
  final Future<SharedPreferences> preferences = SharedPreferences.getInstance();

  Mawa({required this.server, required this.loginScreenID, this.initialScreenID, tenantID}){
    preferences.then((SharedPreferences prefs) {
      return (prefs.setString(SharedPrefs.server, server));
    });
    preferences.then((SharedPreferences prefs) {
      return (prefs.setString(SharedPrefs.loginScreenID, loginScreenID));
    });
    preferences.then((SharedPreferences prefs) {
      return (prefs.setString(SharedPrefs.initialRoute, initialScreenID ?? ''));
    });
    preferences.then((SharedPreferences prefs) {
      return (prefs.setString(SharedPrefs.tenantID, tenantID ?? ''));
    });
  }

}