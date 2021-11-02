// ignore_for_file: avoid_print
part of mawa;

late final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

class Tools{

  static const String productCategoryFuneralPolicy = 'FUNERALPOLICY';
  static const String productCategoryTombstone = 'TOMBSTONE';

  // static late bool isTracking;

  static const String close = 'Close';
  static const String pause = 'Pause';
  static dynamic previousContext;
  static late String lastPage;
  static late BuildContext context;
  static int pageIndex = 0;
  static bool isTouchLocked = false;
  static String screenMessage = '';
  static late Widget body;

  late String email;

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
     User.username = await User().changePassword(password: _newPasswordController.value.text.toString());
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

}