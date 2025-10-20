import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mawa_package/mawa_package.dart';

import 'Dashboard.dart';
import 'home.dart';

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  // DeviceInfo();

  var base = Uri.base.origin;
  var head = base.split('//').last;
  String url = 'dev.api.app.mawa.co.za';
  String tenantID =
      head.contains('localhost') ? url.substring(0, url.indexOf('.')) : head;
  Mawa(
    server: url,
    loginScreenID: AuthenticateView.id,
    initialScreenID: InitialRoute.id,
  );
  runApp(Home());
}
