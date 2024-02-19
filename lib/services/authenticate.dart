part of 'package:mawa_package/mawa_package.dart';

class Authenticate {
  static authorize({
    required String username,
    required String password,
  }) async {
    http.Response response = await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPost,
      resource: Resources.authenticate,
      body: {JsonPayloads.username: username, JsonPayloads.password: password,},
    );
    if (response.statusCode == 200) {
      preferences.then((SharedPreferences prefs) {
        return (prefs.setString(SharedPrefs.username, username,));
      });
      dynamic data = {};
      data = await NetworkRequests.decodeJson(response);
      // User.username = await data[JsonResponses.username];
      NetworkRequests.token = await data[JsonResponses.token];
      Token.refreshToken = await data[JsonResponses.refreshToken] ?? '';
      preferences.then((SharedPreferences prefs) {
        return (prefs.setString(SharedPrefs.token, NetworkRequests.token,));
      });
      preferences.then((SharedPreferences prefs) {
        return (prefs.setString(SharedPrefs.refreshToken, Token.refreshToken));
      });
      //   /*// final String string = (prefs.getString(SharedPreferencesKeys.token) ?? '');
      //
      //  // _key =
      //      prefs.setString(SharedPreferencesKeys.token, string)
      // //      .then((bool success) {
      // //   return token;
      // // })
      // ;*/
      //   await User().getUserDetails(payload![JsonResponses.userID]!);
      //   // Navigator.pushReplacementNamed(context, direct!);
      //   postAuthenticate;
      User.loggedInUser = await User.getByUsername(username);
      Map<String, dynamic> partner = Map<String, dynamic>.from(User.loggedInUser[JsonResponses.partner]);
      User.loggedInUser[JsonResponses.partner] = partner;
      User.loggedInUser[JsonResponses.partnerId] = partner[JsonResponses.id];
      SharedStorage.setString(key: SharedPrefs.userID, detail: User.loggedInUser[JsonResponses.id],);
      SharedStorage.setString(key: SharedPrefs.loggedInUser, detail: jsonEncode(User.loggedInUser),);
    }
    return response;
  }
}
