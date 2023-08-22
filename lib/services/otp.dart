part of 'package:mawa_package/mawa_package.dart';

class OTP {
  OTP(this.context);
  final BuildContext context;
  final String userDoesntExist = 'User does not exist';
  final String invalid = 'INVALID';
  final String expired = 'EXPIRED';
  // const String = '';
  final _tokenFormKey = GlobalKey<FormState>();

  requestOTP(String email) async{
    return await NetworkRequests().unsecuredMawaAPI(
        NetworkRequests.methodPost,
        resource: Resources.otp,
        payload: {JsonPayloads.partnerEmail: email},
        context: context);
  }

  postOTPRequest(request) async {
    String message = await NetworkRequests.decodeJson(request, negativeResponse: '');
    if(request.statusCode == 200 || request.statusCode == 201) {
      if(message != userDoesntExist) {
        otpPopup();
      }
      else{
        Tools().forgotPasswordPopup();
        Alerts.toastMessage(
            message: 'Email Not Associated With Any User',
            positive: false,);
      }
    }
    else{
      Tools().forgotPasswordPopup();
      Alerts.toastMessage(
          message: 'Something went wrong',
          positive: false,
      );
    }

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
              onEditingComplete: () async {
                if(_tokenFormKey.currentState!.validate()){
                  Navigator.of(context).pop();
                  final OverlayWidgets overlay = OverlayWidgets(context: context);
                  overlay.showOverlay(SnapShortStaticWidgets.snapshotWaitingIndicator());

                  // Alerts.flushbar(context: Tools.context, message: 'Please Wait', showProgressIndicator: true, popContext: true);
                  // Navigator.of(context).pop();
                  // Tools().passwordResetPopup(context);
                  await validateOTP(NetworkRequests.otp);
                  overlay.dismissOverlay();
                }
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
          onPressed: () async {
            if(_tokenFormKey.currentState!.validate()){
              Navigator.of(context).pop();
              final OverlayWidgets overlay = OverlayWidgets(context: context);
              overlay.showOverlay(SnapShortStaticWidgets.snapshotWaitingIndicator());

              // Alerts.flushbar(context: Tools.context, message: 'Please Wait', showProgressIndicator: true, popContext: true);
              // Navigator.of(context).pop();
              // Tools().passwordResetPopup(context);
              await validateOTP(NetworkRequests.otp);
              overlay.dismissOverlay();
            }
          },
          color: Colors.green,
          child: const Text('Proceed'),
        ),
        btnCancel: Constants.dialogCloseButton(context: context),
    ).show();
  }

  validateOTP(String pin) async {
    return await NetworkRequests().unsecuredMawaAPI(NetworkRequests.methodGet,
        resource: Resources.otp,
        queryParameters: {QueryParameters.otp: pin},
        context: context);
  }
}
