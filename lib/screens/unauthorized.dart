import 'package:dio/dio.dart'/* as dio*/;
import 'package:http_parser/http_parser.dart' as parser;

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'dart:async';
import 'package:flutter/painting.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:email_validator/email_validator.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:device_information/device_information.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import 'package:mawa/services/attachments.dart';
import 'package:mawa/services/client_policy.dart';
import 'package:mawa/services/constants.dart';
import 'package:mawa/services/device_info.dart';
import 'package:mawa/services/employees.dart';
import 'package:mawa/services/field_options.dart';
import 'package:mawa/services/fields.dart';
import 'package:mawa/services/globals.dart';
import 'package:mawa/services/internet_connect.dart';
import 'package:mawa/services/keys.dart';
import 'package:mawa/services/leaves.dart';
import 'package:mawa/services/location.dart';
import 'package:mawa/services/memberships.dart';
import 'package:mawa/services/network_requests.dart';
import 'package:mawa/services/notification.dart';
import 'package:mawa/services/otp.dart';
import 'package:mawa/services/persons.dart';
import 'package:mawa/services/products.dart';
import 'package:mawa/services/receipts.dart';
import 'package:mawa/services/tasks.dart';
import 'package:mawa/services/tickets.dart';
import 'package:mawa/services/timer.dart';
import 'package:mawa/services/token.dart';
import 'package:mawa/services/tools.dart';
import 'package:mawa/services/transaction_notes.dart';
import 'package:mawa/services/user.dart';
import 'package:mawa/services/versioning.dart';
import 'package:mawa/services/workcenters.dart';
import 'package:mawa/screens/alerts.dart';
import 'package:mawa/screens/authenticate.dart';
import 'package:mawa/screens/init_route.dart';
import 'package:mawa/screens/no_internet_connection.dart';
import 'package:mawa/screens/outdated_version.dart';
import 'package:mawa/screens/snapshort_static_widgets.dart';
import 'package:mawa/screens/unauthorized.dart';

class Unauthorized extends StatelessWidget {
  static const String id = 'Unauthorized';
  String? appName;
  Unauthorized({this.appName});

  @override
  Widget build(BuildContext context) {
    Tools.context = context;
    FocusScope.of(context).unfocus();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // backgroundColor: Colors.blueGrey,
          title: Text(
            appName ?? '',
            style: const TextStyle(
              // fontWeight: FontWeight.bold,
            ),
          ),),
        body: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.error_outline,
                  size: 20.0,),
                Text('You Are Not Authorized To Utilize This Application',
                  style: TextStyle(color: Colors.black,fontSize: 20.0),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
