import 'package:mawa_package/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Token {

  static String refreshToken = '';

  // POST /mawa-api/resources/refreshAuthenticate
  //     Please note that you need to use refresh token to make this call as this is a secure call
  //     {
  //   "userID":"time@"
  // }
  getNewToken(userID) async {

    final SharedPreferences prefs = await preferences;

    String token;

    token = await prefs.getString(SharedPrefs.refreshToken) ?? '';

    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPost,
        resource: Resources.refreshAuthenticate,
      body: {
          QueryParameters.userID: userID,
      },
    );

    if(response.statusCode == 200){
      // NetworkRequests.token = await NetworkRequests.decodeJson(response);
      token = await NetworkRequests.decodeJson(response);

      preferences.then((SharedPreferences prefs) {
        return (prefs.setString(SharedPrefs.token, token));
      });
      return true;
    }
    else{
      return false;
    }
  }
}