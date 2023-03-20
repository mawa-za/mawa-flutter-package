part of 'package:mawa_package/mawa_package.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  late OTP otp;
  final _forgotPasswordFormKey = GlobalKey<FormState>();
  late String email;

  @override
  void initState() {
    super.initState();
    otp = OTP(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: const [
              Icon(Icons.alternate_email),
              Text('Forgot password'),
            ],
          ),
        ),
        body: Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Form(
                    key: _forgotPasswordFormKey,
                    child: TextFormField(
                      autofocus: true,
                      textInputAction: TextInputAction.send,
                      onChanged: (value) {
                        value = value.trim();
                        email = value;
                      },
                      validator: (value) {
                        value = value?.trim();
                        print('*$value*\n*$email*');
                        if (value!.isEmpty) {
                          return 'Enter Email Address';
                        }
                        if (value.isNotEmpty && !EmailValidator.validate(value)) {
                          return 'Please Enter Correct Email Address';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        icon: Icon(Icons.account_circle),
                        labelText: 'Enter Your Email Address',
                      ),
                      onEditingComplete: submitEmail,
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => const OTPScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Already have An OTP',
                        style: TextStyle(color: Colors.blue),
                      )),
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
                        onPressed: submitEmail,
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith(
                              (states) => Colors.green),
                        ),
                        child: const Text('Proceed'),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  submitEmail() async {
    if (_forgotPasswordFormKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();

      final OverlayWidgets overlay = OverlayWidgets(context: context);
      overlay.showOverlay(SnapShortStaticWidgets.snapshotWaitingIndicator());

      dynamic request = await otp.requestOTP(email);
      print('code');
      print('\n${request.statusCode}');
      if(request.statusCode == 200 || request.statusCode == 201) {
        String message = await NetworkRequests.decodeJson(request, negativeResponse: '');
        print('\n message ${message}');
        if(message != otp.userDoesntExist) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const OTPScreen(),
            ),);

        }
        else{
          Alerts.toastMessage(
            message: 'Email Not Associated With Any User',
            positive: false,);
        }
      }
      else{
        Tools().forgotPasswordPopup();
        Alerts.toastMessage(
          message: 'Could not request OTP. Please try again ',
          positive: false,
        );
      }

      overlay.dismissOverlay();
    }
  }
}
