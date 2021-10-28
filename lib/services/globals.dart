
// ignore_for_file: avoid_print
part of mawa;

late String redirect;
final Future<SharedPreferences> preferences = SharedPreferences.getInstance();

setLastPage(String page) async {
  final SharedPreferences prefs = await preferences;

  prefs.setString(SharedPreferences.lastPage, page);
  Tools.lastPage  = page;
  print('now ' + page);
}