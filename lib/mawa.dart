part of 'package:mawa_package/mawa_package.dart';

class Mawa{
  final String server;
  final Future<SharedPreferences> preferences = SharedPreferences.getInstance();

  Mawa({required this.server}){
    preferences.then((SharedPreferences prefs) {
      return (prefs.setString(SharedPrefs.server, server));
    });
  }

}