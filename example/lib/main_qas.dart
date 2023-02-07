import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mawa_package/mawa_package.dart';

import 'Dashboard.dart';
import 'home.dart';

Future<void> main() async{

  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  DeviceInfo();
  Mawa(server: 'qas.api.app.mawa.co.za', initialScreenID: HomePage.id, loginScreenID: Authenticate.id);
  runApp(Home());
}