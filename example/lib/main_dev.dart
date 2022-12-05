import 'dart:io';
import 'package:mawa_package/mawa.dart' as mawa;
import 'package:flutter/material.dart';

import 'home.dart';

Future<void> main() async{

  HttpOverrides.global = mawa.MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  mawa.DeviceInfo();
  runApp(Home(server: 'api-dev.mawa.co.za:8181',));
}