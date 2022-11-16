import 'package:mawa_package/services/constants.dart';
import 'package:mawa_package/services/globals.dart';
import 'package:mawa_package/services/keys.dart';
import 'package:mawa_package/services/network_requests.dart';
import 'package:mawa_package/services/tools.dart';
import 'package:mawa_package/screens/alerts.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/overlay_widgets.dart';
import '../screens/snapshort_static_widgets.dart';

class OTP {
  OTP(this.context);
  final BuildContext context;
  final String _userDoesntExist = 'User does not exist';
  final String _invalid = 'INVALID';
  final String _expired = 'EXPIRED';
  // const String = '';
  final _tokenFormKey = GlobalKey<FormState>();

  postOTPRequest(){
    NetworkRequests.statusCode == 200 || NetworkRequests.statusCode == 201 && NetworkRequests.otp != _userDoesntExist
        ? otpPopup()
        : Alerts.flushbar(
        context: Tools.context,
        message: _userDoesntExist,
        positive: false,
        popContext: false);

  }

  otpPopup({String? message}) {
    Tools.isTouchLocked = false;
    return AwesomeDialog(
        context: context,
        title: 'One Time Pin',
        body: Column(children: [
          Text(message ?? '',textAlign: TextAlign.center, style: const TextStyle(color: Colors.redAccent),),
          Form(
            key: _tokenFormKey,
            child: TextFormField(
              keyboardType: TextInputType.number,

              autofocus: true,
              textInputAction: TextInputAction.send,
              onChanged: (value) {
                NetworkRequests.otp = value;
              },
              validator: (value){
                if( value!.isEmpty) {
                  return 'Enter OTP Key';
                }
                return null;
              },
              decoration: const InputDecoration(
                icon: Icon(Icons.lock_clock),
                labelText: 'OTP Your Mail or Messages',
              ),
              onEditingComplete: (){
                Navigator.of(context).pop();
                // validateOTP();
                Tools().forgotPasswordPopup();
              },
            ),
          ),
          TextButton(
            child: const Text('Resend OTP',
              style: TextStyle(color: Colors.blue),
            ),
            onPressed: (){
              Navigator.of(context).pop();
              // validateOTP();
              Tools().forgotPasswordPopup();
            },
          ),
        ]
        ),
        btnOk: DialogButton(
          child: const Text('Proceed'),
          onPressed: () async {
            if(_tokenFormKey.currentState!.validate()){
              Navigator.of(context).pop();
              final OverlayWidgets overlay = OverlayWidgets(context: context);
              overlay.showOverlay(SnapShortStaticWidgets.snapshotWaitingIndicator());

              // Alerts.flushbar(context: Tools.context, message: 'Please Wait', showProgressIndicator: true, popContext: true);
              // Navigator.of(context).pop();
              // Tools().passwordResetPopup(context);
              await validateOTP();
              overlay.dismissOverlay();
            }
          },
          color: Colors.green,
        ),
        btnCancel: Constants.dialogCloseButton(context: context),
    ).show();
  }

  validateOTP() async {
    await NetworkRequests().unsecuredMawaAPI(NetworkRequests.methodGet,
        resource: Resources.otp,
        queryParameters: {QueryParameters.otp: NetworkRequests.otp},
        context: context);
    if (NetworkRequests.statusCode == 200) {
      if (NetworkRequests.otp == _invalid) {
        Alerts.flushbar(
            context: Tools.context,
            message: 'OTP Invalid',
            positive: false,
            popContext: false);
      } else if (NetworkRequests.otp == _expired) {
        Alerts.flushbar(
            context: Tools.context,
            message: 'OTP Has Expired',
            positive: false,
            popContext: false);
      } else {
        NetworkRequests.token = NetworkRequests.otp;//.substring(1,NetworkRequests.otp.length);

        preferences.then((SharedPreferences prefs) {
          return (prefs.setString(SharedPrefs.token, NetworkRequests.token));
        });
        Tools().passwordResetPopup(context);
      }
    }
  }
}
