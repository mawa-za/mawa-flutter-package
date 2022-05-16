import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:mawa/services/constants.dart';
import 'package:mawa/services/tools.dart';
import 'package:mawa/services/versioning.dart';
import 'package:mawa/screens/no_internet_connection.dart';
import 'package:mawa/screens/outdated_version.dart';
import 'package:mawa/screens/snapshort_static_widgets.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class InitialRoute extends StatefulWidget {
  static const String id = 'Init Route';
  var className;
  InitialRoute({this.className});
  @override
  _InitialRouteState createState() => _InitialRouteState();
}

class _InitialRouteState extends State<InitialRoute> {
  late Widget body;
  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  Future<void> initConnectivity() async {
    ConnectivityResult? result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      // print(e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result!);
  }

  future() async {
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    await ApkVersion().getApkInfo();
  }

  @override
  void initState() {
    // TODO: implement initState
    // FocusScope.of(context).unfocus();
    super.initState();
  }

  @override
  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      case ConnectivityResult.none:
        _connectionStatus = result.toString(); //);
        break;
      default:
        _connectionStatus = 'Failed to get connectivity.'; //);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    Tools.context = context;
    return WillPopScope(
      onWillPop: () => Constants.promptExit(context),
      child: AbsorbPointer(
        absorbing: Tools.isTouchLocked,
        child: Scaffold(
          body: FutureBuilder(
              future: future(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {

                  if(ApkVersion.apkUsable != null &&
                      ApkVersion.apkUsable == false) {
                    body = OutdatedAPK();
                  }
                      else{
                        if(_connectionStatus == ConnectivityResult.wifi.toString() ||
                        _connectionStatus == ConnectivityResult.mobile.toString()){
                        //   if(mawa.NetworkRequests.statusCode == 200){
                        //     body = DashBoard();
                          // }
                          // else{
                            body = widget.className;//Authenticate();
                          // }
                        }
                        else {
                          body = NoConnectionScreen(
                            redirect: InitialRoute.id,);
                        }

                  }
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  body =
                      SnapShortStaticWidgets.snapshotWaitingIndicator();
                } else if (snapshot.hasError) {
                  body = SnapShortStaticWidgets.snapshotError();
                } else {
                  body = SnapShortStaticWidgets.futureNoData();
                }

                return body;
              }),
        ),
      ),
    );
  }

  checkServer() {}
}
