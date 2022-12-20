part of 'package:mawa_package/mawa_package.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreentate();
}

class _OTPScreentate extends State<OTPScreen> {
  late OTP otp;
  late String pin;
  @override
  void initState() {
    super.initState();
    otp = OTP(context);
  }

  final _tokenFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: const [
              Icon(Icons.pin),
              Text('One Time Pin'),
            ],
          ),
        ),
        body:Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 3,
              child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Form(
                      key: _tokenFormKey,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        autofocus: true,
                        textInputAction: TextInputAction.send,
                        onChanged: (value) {
                          NetworkRequests.otp = value;
                          pin = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter OTP Key';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          icon: Icon(Icons.lock_clock),
                          labelText: 'OTP Your Mail or Messages',
                        ),
                        onEditingComplete: submit,
                      ),
                    ),
                    TextButton(
                      child: const Text(
                        'Resend OTP',
                        style: TextStyle(color: Colors.blue),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => const ForgotPassword(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith(
                                    (states) => Colors.red),
                          ),
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: submit,
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith(
                                    (states) => Colors.green),
                          ),
                          child: const Text('Proceed'),
                        ),
                      ],
                    )
                  ]),
            ),
            const Spacer(),
          ],
        ),

      ),
    );
  }

  void submit() async {
    if (_tokenFormKey.currentState!.validate()) {
      final OverlayWidgets overlay = OverlayWidgets(context: context);
      overlay.showOverlay(SnapShortStaticWidgets.snapshotWaitingIndicator());

      // Alerts.flushbar(context: Tools.context, message: 'Please Wait', showProgressIndicator: true, popContext: true);
      // Navigator.of(context).pop();
      // Tools().passwordResetPopup(context);
      dynamic response = await otp.validateOTP(pin);
      if (response.statusCode == 200) {
        dynamic data = await NetworkRequests.decodeJson(response);
        if (data == otp.invalid) {
          Alerts.toastMessage(
            message: 'OTP Invalid',
            positive: false,
          );
        } else if (data == otp.expired) {
          Alerts.toastMessage(
            message: 'OTP Has Expired',
            positive: false,
          );
        } else {
          NetworkRequests.token =
              NetworkRequests.otp; //.substring(1,NetworkRequests.otp.length);

          preferences.then((SharedPreferences prefs) {
            return (prefs.setString(SharedPrefs.token, NetworkRequests.token));
          });
          Navigator.pushReplacement(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const ChangePassword(),
            ),
          );
        }
      } else {
        Alerts.toastMessage(
          message: 'Could not verify OTP.\nPlease try again',
          positive: false,
        );
      }

      overlay.dismissOverlay();
    }
  }
}
