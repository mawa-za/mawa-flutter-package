import 'package:mawa_package/mawa_package.dart';
import 'Dashboard.dart';
import 'package:flutter/material.dart';

// 0649
AuthenticateView _authenticate(context) {
  return AuthenticateView(
    logo: const Image(
      image: AssetImage('assets/images/appicon.png', package: 'mawa_package'),
    ),
// Image.asset('packages/mawa_package/assets/images/app_icon.png'),
    route: HomePage.id,
    postAuthenticate: () {
      if (AuthenticateView.response.statusCode == 200) {
        Navigator.pushNamed(context, redirect);
      } else {
        Navigator.pushNamed(context, Unauthorized.id);
      }
    },
  );
}

var route = {
  AuthenticateView.id: (context) => _authenticate(context),
  HomePage.id: (context) => const HomePage(),
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
  UserOverview.id: (context) => UserOverview(widget: Container(), user: 'ME')
};
