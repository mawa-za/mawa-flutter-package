part of 'package:mawa_package/mawa_package.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  bool emailSent=false;
  bool errorMessage=false;
  late String submitBtnText;
  final _forgotPasswordFormKey = GlobalKey<FormState>();
  late String email;
  @override
  void initState() {
    super.initState();
    email ='';
    submitBtnText ='Send';
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Row(
            children: [
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
                  //  Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     Visibility(
                  //       visible:emailSent,
                  //       child: Text(
                  //         'Reset link was sent to the user "$email" email, check your email',
                  //         style: const TextStyle(
                  //           // decoration: TextDecoration.underline,
                  //           color: Colors.green,
                  //           fontSize: 15.0,
                  //           // fontWeight: FontWeight.bold,
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
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
                        if (value!.isEmpty) {
                          return 'Enter Username';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        icon: Icon(Icons.account_circle),
                        labelText: 'Enter Your Username',
                      ),
                      onEditingComplete: submitEmail,
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Visibility(
                        visible:emailSent,
                        child: const Text(
                          'Did not received email?',
                          style:  TextStyle(
                            // decoration: TextDecoration.underline,
                            color: Colors.blue,
                            fontSize: 15.0,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      const SizedBox(
                        width: 15.0,
                      ),
                      ElevatedButton(
                        onPressed: submitEmail,
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith(
                                  (states) => Colors.green),
                        ),
                        child:  Text(submitBtnText),
                      ),
                    ],

                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Visibility(
                        visible:emailSent,
                        child: Flexible(
                          flex: 1,
                          child: Text(
                            'Reset link was sent to the user "$email" email, check your email',
                            style: const TextStyle(
                              color: Colors.green,
                              fontSize: 15.0,
                              // fontWeight: FontWeight.bold,
                            ),
                            softWrap:true,
                          ),
                        ),
                      ),
                      Visibility(
                        visible:errorMessage,
                        child: const Flexible(
                          flex: 1,
                          child: Text(
                            'Oops!.., something went wrong please contact system administrator',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 15.0,
                              // fontWeight: FontWeight.bold,
                            ),
                            softWrap:true,
                          ),
                        ),
                      )
                    ],
                  ),
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
    final OverlayWidgets overlay = OverlayWidgets(
      context: context,
    );
    if (_forgotPasswordFormKey.currentState!.validate()) {
      overlay.showOverlay(
        SnapShortStaticWidgets.snapshotWaitingIndicator(),
      );
      FocusScope.of(context).unfocus();
      dynamic response = await ResetPassword.passUserName(user: email ?? '');

      if(response.statusCode == 200 || response.statusCode == 201) {
        setState(() {
          emailSent = true;
          errorMessage = false;
          submitBtnText ="Resend";
        });
      }else{
        setState(() {
          errorMessage = true;
          emailSent = false;
          submitBtnText ="Send";
        });
      }
    } else {


      // Alerts.toastMessage(
      //   message: 'Could not send email ',
      //   positive: false,
      // );
    }
    overlay.dismissOverlay();

  }

}
