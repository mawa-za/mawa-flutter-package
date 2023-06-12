import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mawa_package/dependencies.dart';
import 'package:mawa_package/mawa_package.dart';
import 'routes.dart';

class Home extends StatelessWidget {
  Home({Key? key,}) : super(key: key);

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
        .securedMawaAPI(NetworkRequests.methodGet, resource: Resources.user);
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

  redirect =  UserOverview.id;
    // DeviceInfo();

    return MaterialApp(
      // routes: route,
      home: AttachBase64File(afterUpload: (){print('object');},),
      // initialRoute: initialRoute,
      onUnknownRoute: (settings) {
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (BuildContext context) {
            // Navigator.pop(context);
            return PageNotFound();
          },
        );
      },
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
