// ignore_for_file: avoid_print
part of mawa;

late final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

class Tools{

  static const String productCategoryFuneralPolicy = 'FUNERALPOLICY';
  static const String productCategoryTombstone = 'TOMBSTONE';

  // static late bool isTracking;

  static const String close = 'Close';
  static const String TRANSACTION = 'TRANSACTION';
  static const String LEAVEREQUEST = 'LEAVEREQUEST';
  static const String INVOICE = 'INVOICE';
  static const String TICKETTRACKING = 'TICKETTRACKING';
  static const String pause = 'Pause';
  static const String stop = 'Stop';
  static const String resolve = 'Resolve';
  static dynamic previousContext;
  static late String lastPage;
  static late BuildContext context;
  static int pageIndex = 0;
  static bool isTouchLocked = false;
  static String screenMessage = '';
  static late Widget body;
  static late String attachmentReference;
  static late String documentType;
  static late String parentType;
  late String email;

  static bool bannerShow = false;
  static String bannerMessage = '';

  static String? personCreateRole;
  static final flashKey = GlobalKey<FormState>();

  static const String endpointURL =
      'https://api-dev.mawa.co.za:8181/mawa-api/resources';

  // 'http://mawa-test.raretag.co.za:8080/mawa-api/resources/';

  // 'mawa-test.raretag.co.za:8080/mawa-api/resources/';

  final _resetPasswordFormKey = GlobalKey<FormState>();

  final TextEditingController _newPasswordController = TextEditingController();
  dynamic resetPasswordFeedback;

  final _forgotPasswordFormKey = GlobalKey<FormState>();
  final _tokenFormKey = GlobalKey<FormState>();

  submitEmail() async {
    Navigator.of(context).pop();
    Alerts.flushbar(context: context, message: 'Please Wait');
    await NetworkRequests().unsecuredMawaAPI(NetworkRequests.methodPost,
        resource: Resources.otp, payload: {JsonPayloads.partnerEmail: email}, context: context);
    Tools.isTouchLocked = true;
    Authenticate.message = 'Please Wait';
    OTP(context).postOTPRequest();
    // NetworkRequests.statusCode == 200 || NetworkRequests.statusCode == 201 && NetworkRequests.token != OTP.userDoesntExist
    //     ? tokenPopup()
    //     : forgotPasswordPopup( message: 'Email Not Associated With Any User');
    Tools.isTouchLocked = false;
    Authenticate.message = '';
  }

  forgotPasswordPopup({String? message}) {
    return AwesomeDialog(
        context: context,
        title: 'Forgot Password',
        body: Column(
          children: [
            Text(message ?? '', style: const TextStyle(color: Colors.red)),
            Form(
              key: _forgotPasswordFormKey,
              child: TextFormField(

                autofocus: true,
                textInputAction: TextInputAction.send,
                onChanged: (value) {
                  email = value;
                },
                validator: (value) {
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
                onEditingComplete:  () => _forgotPasswordFormKey.currentState!.validate()
                    ? submitEmail()
                    : null,
              ),
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  OTP(context).otpPopup();
                },
                child: const Text(
                  'Already have An OTP',
                  style: TextStyle(color: Colors.blue),
                ))
          ],
        ),
        btnOk: DialogButton(
            child: const Text('Proceed'),
            onPressed: () => _forgotPasswordFormKey.currentState!.validate()
                ? submitEmail()
                : null,
            color: Colors.green,
          ),
        btnCancel: Constants.dialogCloseButton(context: context),
        ).show();
  }

  static final Map<String, int> tabs = {
    'Balance':0,
    'History':1,
    'Approvals':2,
    // SearchTicket.id: 0,
    // MyTickets.id: 1,
    // NewTickets.id: 2,
    // TrackTicket.id: 4,
  };

  static final Widget exitIconButton = ElevatedButton.icon(onPressed: () => Navigator.popAndPushNamed(context, Authenticate.id), icon: const Icon(Icons.exit_to_app), label: const Text('exit'));

  static final Widget exit = GestureDetector(child: const Icon(Icons.exit_to_app), onTap: () => Navigator.popAndPushNamed(context, Authenticate.id),);

  _resetPassword(/*context*/) async {
    Navigator.of(context).pop();

    FocusScope.of(context).unfocus();

    Alerts.flushbar(message: 'Please Wait', context: context);
     User.username = NetworkRequests.decodeJson(await User().changePassword(password: _newPasswordController.value.text.toString()));
    NetworkRequests.statusCode == 200 || NetworkRequests.statusCode == 201
        ?  Navigator.pushReplacementNamed(context, redirect)
        : NetworkRequests.statusCode == 401
        ?

    Authenticate.message = 'Token Invalid'
        : Alerts.flushbar(context: context, message:'Failed To Reset', positive: false, popContext: true);
    print('done!');
  }

  passwordResetPopup(context) {
    return AwesomeDialog(
        context: context,
        title: 'Reset Password',
        body: Form(
          key: _resetPasswordFormKey,
          child: Column(
            children: [
              TextFormField(
                autofocus: true,
                textInputAction: TextInputAction.next,
                controller: _newPasswordController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter New Password';
                  }
                  if (value.length < 7) {
                    return 'Password Short';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  icon: Icon(Icons.account_circle),
                  labelText: 'Enter New Password',
                ),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                textInputAction: TextInputAction.send,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Retype New Password';
                  }
                  if (value != _newPasswordController.value.text.toString()) {
                    return 'Passwords Do Not Match';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  icon: Icon(Icons.account_circle),
                  labelText: 'Confirm Password',
                ),
                onEditingComplete: (){
                  if (_resetPasswordFormKey.currentState!.validate()) {
                    // Navigator.of(context).pop();
                    _resetPassword(/*context*/);
                  }
                },
              ),
            ],
          ),
        ),
        btnOk: DialogButton(
            onPressed: () {
              print(_newPasswordController.value.text.toString());
              if (_resetPasswordFormKey.currentState!.validate()) {
                // Navigator.of(context).pop();
                _resetPassword(/*context*/);
              }
            },
            child: const Text(
              'Confirm',
            ),
            color: Colors.green,
          ),
      btnCancel: Constants.dialogCloseButton(context: context),
        ).show();
  }

  static logoutPopup({required BuildContext context, required String redirect}) {
    return Alert(
      context: context,
      title: 'Alert',
      content: const Text('Do you really want to logout?'),
      buttons: [
        DialogButton(
          child: const Text('Yes'),
          onPressed: () => Navigator.of(context)
              .pushNamedAndRemoveUntil(redirect, (route) => false),
          color: Colors.greenAccent,
        ),
        Constants.dialogCloseButton(text: 'No', context: context),
      ],
    ).show();
  }

  // _resetPassword(/*context*/) async {
  //   Navigator.of(context!).pop();
  //
  //   // AuthenticationScreen.message = 'Please Wait';
  //   // Alerts().pleaseWaitToast();
  //   // Alerts.mawaBanner(context: context, message: 'Please Wait');
  //   FocusScope.of(context!).unfocus();
  //
  //   Alerts.flushbar.show(context!);
  //   // AuthenticationScreen.message = await User().changePassword(password: _newPasswordController.value.text.toString());
  //   User.userID = await User().changePassword(password: _newPasswordController.value.text.toString());
  //   NetworkRequests.statusCode == 200 || NetworkRequests.statusCode == 201
  //   // ? Alerts.mawaBanner(context: context, message: AuthenticationScreen.message,positive: true, popContext: true)
  //       ?  Navigator.pushReplacement(context!, MaterialPageRoute(builder: (context) {return initiatePrintSequence();}))
  //       : NetworkRequests.statusCode == 401
  //       ?
  //   //         Alerts().openPopup(context, message: 'Token Was Invalid Or Has Expired')
  //
  //   AuthenticationScreen.message = 'Token Invalid'
  //   // Alerts.mawaBanner(context: context, message: 'Token Was Invalid Or Has Expired', positive: false, popContext: true)
  //   //     : Alerts().openPopup(context, message:'Failed To Reset');
  //       : Alerts.mawaFlushBar(context: context!, message:'Failed To Reset', positive: false, popContext: true);
  //   // LoginScreen().createState();
  //   // setState(() {
  //   // });
  //   print('done!');
  // }
  //
  // passwordResetPopup(context) {
  //   return Alert(
  //       context: context,
  //       title: 'Reset Password',
  //       content: Container(
  //         child: Form(
  //           key: _resetPasswordFormKey,
  //           child: Column(
  //             children: [
  //               TextFormField(
  //                 controller: _newPasswordController,
  //                 validator: (value) {
  //                   if (value!.isEmpty) {
  //                     return 'Enter New Password';
  //                   }
  //                   if (value.length < 5) {
  //                     return 'Password Too Short';
  //                   }
  //                   return null;
  //                 },
  //                 decoration: InputDecoration(
  //                   icon: Icon(Icons.account_circle),
  //                   labelText: 'Enter New Password',
  //                 ),
  //               ),
  //               SizedBox(height: 10.0),
  //               TextFormField(
  //                 validator: (value) {
  //                   if (value!.isEmpty) {
  //                     return 'Retype New Password';
  //                   }
  //                   if (value != _newPasswordController.value.text.toString()) {
  //                     return 'Passwords Do Not Match';
  //                   }
  //                   return null;
  //                 },
  //                 decoration: InputDecoration(
  //                   icon: Icon(Icons.account_circle),
  //                   labelText: 'Confirm Password',
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //       buttons: [
  //         DialogButton(
  //           onPressed: () {
  //             print(_newPasswordController.value.text.toString());
  //             if (_resetPasswordFormKey.currentState!.validate()) {
  //               // Navigator.of(context).pop();
  //               _resetPassword(/*context*/);
  //             }
  //           },
  //           child: Text(
  //             'Confirm',
  //           ),
  //           color: Colors.green,
  //         ),
  //         DialogButton(
  //           onPressed: () => Navigator.of(context).pop(),
  //           child: Text('Cancel'),
  //           color: Colors.orange,
  //         )
  //       ]).show();
  // }

//
  static textInputDecorations(String textLabel, icon, {String? hint, String? helperTxt}) {
    return InputDecoration(
        helperText: helperTxt ?? '',
        icon: Icon(icon),
        labelText: textLabel,
        hintText: hint,
        filled: true,
        fillColor: Colors.grey[100],
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ));
  }

  static textInputDecoration(String textLabel, {String? hint, String? helperTxt}) {
    return InputDecoration(
        helperText: helperTxt ?? '',
        labelText: textLabel,
        hintText: hint,
        filled: true,
        fillColor: Colors.grey[100],
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ));
  }

  static dropdownContainerDeco() {
    return BoxDecoration(
      color: Colors.grey[100],
      borderRadius: const BorderRadius.all(
        Radius.circular(10.0),
      ),
      border: Border.all(color: Colors.grey, width: 2.0),
    );
    // BoxDecoration(
    //   border: Border.all(
    //     color: Colors.grey[700],
    //     // width: 8,
    //   ),
    //   color: Colors.grey[100],
    //   borderRadius: BorderRadius.all(Radius.circular(10.0)),
    // );
  }

}