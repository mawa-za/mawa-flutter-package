import 'package:example/Dashboard.dart';
import 'package:flutter/material.dart';
import 'package:mawa_package/screens.dart';
import 'package:mawa_package/services/globals.dart';

// 0649
Authenticate _authenticate(context) {
  return Authenticate(
    logo: const Image(
      image: AssetImage('assets/images/appicon.png', package: 'mawa_package'),
    ),
// Image.asset('packages/mawa_package/assets/images/app_icon.png'),
    route: HomePage.id,
    postAuthenticate: () {
      if (Authenticate.response.statusCode == 200) {
        Navigator.pushNamed(context, redirect);
      } else {
        Navigator.pushNamed(context, Unauthorized.id);
      }
    },
  );
}

var route = {
  Authenticate.id: (context) => _authenticate(context),
  HomePage.id: (context) => HomePage(),
  InitialRoute.id: (context) => InitialRoute(
        className: _authenticate(context),
      ),
  SnapshotWaitingIndicator.id: (context) => SnapshotWaitingIndicator(),
  SnapshotError.id: (context) => SnapshotError(),
  OutdatedAPK.id: (context) => OutdatedAPK(),
  NoConnectionScreen.id: (context) => NoConnectionScreen(
        redirect: HomePage.id,
      ),
  Unauthorized.id: (context) => Unauthorized(
        appName: 'Effortless Tracker',
      ),
};
