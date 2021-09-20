part of mawa;

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

  otpPopup() {
    Tools.isTouchLocked = false;
    return Alert(
        context: context,
        title: 'One Time Pin',
        content: Column(children: [
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
                labelText: 'OTP Your Mail  or Messages',
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
        buttons: [
          DialogButton(
            child: const Text('Proceed'),
            onPressed: () {
              if(_tokenFormKey.currentState!.validate()){
                Alerts.flushbar(context: Tools.context, message: 'Please Wait', showProgressIndicator: true, popContext: true);
                // Navigator.of(context).pop();
                // Tools().passwordResetPopup(context);
                validateOTP();
              }
            },
            color: Colors.green,
          ),
          Constants.dialogCloseButton(context: context),
        ]
    ).show();
  }

  validateOTP() async {
    await NetworkRequests().unsecuredMawaAPI(NetworkRequests.methodGet,
        resource: Resources.otp,
        queryParameters: {JsonPayloadKeys.otp: NetworkRequests.otp},
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
        NetworkRequests.token = NetworkRequests.otp.substring(1,NetworkRequests.otp.length);
        print('\n' + NetworkRequests.otp + '\n' + NetworkRequests.token + '\n' );
        Tools().passwordResetPopup(context);
      }
    }
  }
}
