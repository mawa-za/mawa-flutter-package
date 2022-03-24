import 'package:mawa/services.dart';
import 'package:mawa/screens.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/painting.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class Time {
  static late bool showPopup;
  static DateTime? startTime;
  static DateTime? dueTime;
  static DateTime? endTime;
  static DateTime? duration;

  static const String startTimeString = 'startTime';
  static const String endTimeString = 'endTime';
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  static const isHours = true;

  static
  final StopWatchTimer countUpTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
    // onChange: (value) => print('onChange $value'),
    // onChangeRawSecond: (value) => print('onChangeRawSecond $value'),
    // onChangeRawMinute: (value) => print('onChangeRawMinute $value'),
  );

  static StopWatchTimer countDownTimer = StopWatchTimer(
    mode: StopWatchMode.countDown,
    // presetMillisecond: StopWatchTimer.getMilliSecFromSecond(3),
    // presetMillisecond: StopWatchTimer.getMilliSecFromSecond(DateTime.parse('2021-09-04 19:54:12').difference(DateTime.now()).inSeconds),
    presetMillisecond: StopWatchTimer.getMilliSecFromSecond(
        dueTime != null? dueTime!.difference(DateTime.now()).inSeconds : 0),
    // onChange: (value) => print('onChange $value'),
    // onChangeRawSecond: (value) => print('onChangeRawSecond $value'),
    // onChangeRawMinute: (value) => print('onChangeRawMinute $value'),
    onEnded: () {

  var route = ModalRoute.of(Tools.context);

  if(route!=null){
  print(route.settings.name);
  if(route.settings.name.toString() !=  Tickets.pageId!){
      // if(Tools.context.owner !=  TrackTicket()) {
      if(showPopup) {
        Navigator.pushNamed(Tools.context, Tickets.pageId!);
        Alerts().openPopup(Tools.context, message: 'You AreOut Of Time',
            title: 'Ticket Is Due');
        showPopup =false;
      }
        }
      }
    },
  );

  static final StopWatchTimer timer = _watch();

  static StopWatchTimer _watch(){

    return StopWatchTimer(
      mode: StopWatchMode.countDown,
      // presetMillisecond: StopWatchTimer.getMilliSecFromSecond(3),
      presetMillisecond: StopWatchTimer.getMilliSecFromSecond(
          dueTime!.difference(DateTime.now()).inSeconds),
      onChange: (value) => print('onChange $value'),
      onChangeRawSecond: (value) => print('onChangeRawSecond $value'),
      onChangeRawMinute: (value) => print('onChangeRawMinute $value'),
      onEnded: () {
        print('onEnded');
      },
    );
  }

  getStartTime()async {
    startTime = _prefs.then((SharedPreferences prefs) {
      return (prefs.getInt(startTimeString));
    }) as DateTime?;
  }

  setStartTime({required DateTime time})async {
  final SharedPreferences prefs = await _prefs;

  startTime = prefs.setString(startTimeString, time.toString()).then((bool success) {
    return time;
  }) as DateTime?;
}

  convertToTimeDate()async {
    return  DateTime.parse('2020-01-02 03:04:05');
  }

  calculateDuration()async{
    return startTime!.difference(endTime!);
  }

  static List<Widget> counter ({bool isTap = true}) {
    if(!Tickets.isTracking){
      Tickets.isTracking = false;
    }
    return [Tickets.isTracking ? GestureDetector(
      // onTap: () => isTap ? Navigator.pushNamed(Tools.context, TrackTicket.id):null,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 0),
        child: StreamBuilder<int>(
          stream: Time.countDownTimer.rawTime,
          initialData: Time.countDownTimer.rawTime.value,
          builder: (context, snap) {
            final value = snap.data!;
            final displayTime =
            StopWatchTimer.getDisplayTime(value, hours: Time.isHours);
            return Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    'Due in: ' + displayTime,
                    style: const TextStyle(
                      // fontSize: 40,
                        fontFamily: 'Helvetica',
                        fontWeight: FontWeight.bold),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8),
                //   child: Text(
                //     value.toString(),
                //     style: const TextStyle(
                //         fontSize: 16,
                //         fontFamily: 'Helvetica',
                //         fontWeight: FontWeight.w400),
                //   ),
                // ),
              ],
            );
          },
        ),
      ),
    ) : Container(),
    ];
  }
  }
