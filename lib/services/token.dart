import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:mawa/screens.dart';
import 'package:mawa/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class Token {

  static String refreshToken = '';
  // static late String token;

   final StopWatchTimer sessionTimer = StopWatchTimer(
    mode: StopWatchMode.countDown,
    presetMillisecond: StopWatchTimer.getMilliSecFromSecond(10),

     // onChange: (value) => print('onChange $value'),
     onChangeRawSecond: (value) => print('onChangeRawSecond $value'),
     // onChangeRawMinute: (value) => print('onChangeRawMinute $value'),
     onEnded: () async {
      print('on ended');

      Alerts.flushbar(context: Tools.context, message: 'message');
      String initRoute;

      final SharedPreferences prefs = await preferences;

      initRoute = prefs.getString(SharedPrefs.server) ?? '';

      var route = ModalRoute.of(Tools.context);

      if(route!=null){
        // print(route.settings.name);
        if(route.settings.name.toString() !=  initRoute){
          // if(Tools.context.owner !=  TrackTicket()) {
            AwesomeDialog(context: Tools.context, desc: 'Are You Still Working?',
                title: 'No Activity Detected', );
        }
      }
    },
     // onStop:(){},
  );

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

  void setToken(String token) async {

    preferences.then((SharedPreferences prefs) {
      return (prefs.setString(SharedPrefs.token, token));
    });

  }

  endSession() {

    NetworkRequests.token = '';

    preferences.then((SharedPreferences prefs) {
      return (prefs.setString(SharedPrefs.token, ''));
    });
  }
  sessionTracker() {
    print('viz');
    // sessionTimer.setPresetMinuteTime(10);
    // List list = [];

    sessionTimer.onExecute.add(StopWatchExecute.stop);

    sessionTimer.setPresetSecondTime(10);

    sessionTimer.onExecute.add(StopWatchExecute.reset);

    sessionTimer.onExecute.add(StopWatchExecute.start);

  }
}