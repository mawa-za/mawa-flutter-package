part of 'package:mawa_package/mawa_package.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _resetPasswordFormKey = GlobalKey<FormState>();

  final TextEditingController _newPasswordController = TextEditingController();
  dynamic resetPasswordFeedback;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: const [
              Icon(Icons.lock),
              Text('Change password'),
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
                      key: _resetPasswordFormKey,
                      child: Column(
                        children: [
                          TextFormField(
                            autofocus: true,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
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
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            textInputAction: TextInputAction.send,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Retype New Password';
                              }
                              if (value !=
                                  _newPasswordController.value.text
                                      .toString()) {
                                return 'Passwords Do Not Match';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              icon: Icon(Icons.account_circle),
                              labelText: 'Confirm Password',
                            ),
                            onEditingComplete: _resetPassword,
                          ),
                        ],
                      ),
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
                          onPressed: _resetPassword,
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith(
                                (states) => Colors.green),
                          ),
                          child: const Text(
                            'Confirm',
                          ),
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

  _resetPassword(/*context*/) async {
    if (_resetPasswordFormKey.currentState!.validate()) {
      final OverlayWidgets overlay = OverlayWidgets(context: context);
      overlay.showOverlay(SnapShortStaticWidgets.snapshotWaitingIndicator());

      FocusScope.of(context).unfocus();

      // Alerts.flushbar(message: 'Please Wait', context: context);
      dynamic request = await User.changePassword(
          password: _newPasswordController.value.text.toString());
      User.username = await NetworkRequests.decodeJson(request);
      if (request.statusCode == 200 || request.statusCode == 201) {
        final SharedPreferences prefs = await preferences;

        String initialScreen = prefs.getString(SharedPrefs.initialRoute) ?? '';

        Navigator.pushReplacementNamed(context, initialScreen);
      } else if (request.statusCode == 401) {
        Authenticate.message = 'Token Invalid';
      } else {
        Alerts.flushbar(
            context: context,
            message: 'Failed To Reset',
            positive: false,
            popContext: true);
      }
      overlay.dismissOverlay();
    }
  }
}
