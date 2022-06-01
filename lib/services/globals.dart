import 'package:mawa_package/services/keys.dart';
import 'package:mawa_package/services/tools.dart';
import 'package:shared_preferences/shared_preferences.dart';

late String redirect;
final Future<SharedPreferences> preferences = SharedPreferences.getInstance();

setLastPage(String page) async {
  final SharedPreferences prefs = await preferences;

  prefs.setString(SharedPrefs.lastPage, page);
  Tools.lastPage  = page;
}