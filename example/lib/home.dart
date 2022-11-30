import 'dart:async';

import 'Dashboard.dart';
import 'package:flutter/material.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:mawa_package/dependencies.dart';
// import 'package:mawa_package/services.dart' as mawa;
import 'package:mawa_package/mawa_package.dart';
import 'routes.dart';

class Home extends StatelessWidget {
  Home({Key? key, required this.server}) : super(key: key);

  final String server;
  late String initialRoute;

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  // DeviceInfo devive = DeviceInfo();
  String _connectionStatus = 'Unknown';

  @override
  void initState() {
    // super.initState();
    // initConnectivity();

    NetworkRequests()
        .securedMawaAPI(NetworkRequests.methodGet, resource: Resources.users);
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
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
    initialRoute = InitialRoute.id;
    preferences.then((SharedPreferences prefs) {
      return (prefs.setString(SharedPrefs.initialRoute, initialRoute));
    });
    preferences.then((SharedPreferences prefs) {
      return (prefs.setString(SharedPrefs.server, server));
    });
  redirect =  HomePage.id;
    // DeviceInfo();

    return MaterialApp(
      routes: route,
      // home: HomePage(),
      initialRoute: initialRoute,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.white,
        // const Color(0xFFB398),
        backgroundColor: Colors.white,
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          // primary: const Color(0xFF45ABA6),
          primary: Colors.black,
          enableFeedback: false,
        )),
      ),
    );
  }
}
