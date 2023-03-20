part of 'package:mawa_package/mawa_package.dart';

late String redirect;
final Future<SharedPreferences> preferences = SharedPreferences.getInstance();

setLastPage(String page) async {
  final SharedPreferences prefs = await preferences;

  prefs.setString(SharedPrefs.lastPage, page);
  Tools.lastPage  = page;
}