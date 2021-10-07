library mawa;

import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'dart:async';
import 'package:flutter/services.dart';
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

part 'screens/alerts.dart';
part 'screens/authenticate.dart';
part 'screens/no_internet_connection.dart';
part 'screens/outdated_version.dart';
part 'screens/snapshort_static_widgets.dart';
part 'services/constants.dart';
part 'services/globals.dart';
part 'services/internet_connect.dart';
part 'services/keys.dart';
part 'services/network_requests.dart';
part 'services/otp.dart';
part 'services/tools.dart';
part 'services/user.dart';
part 'services/versioning.dart';
part 'services/client_policy.dart';
part 'services/employees.dart';
part 'services/leaves.dart';
part 'services/fields.dart';
part 'services/persons.dart';
part 'services/memberships.dart';