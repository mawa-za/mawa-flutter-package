part of 'package:mawa_package/mawa_package.dart';

class ChangePassword {
  ChangePassword(this.context,{this.user}) {
    user == null ? isOwner = true: isOwner = false;
    build();
  }
  final BuildContext context;
  late bool isOwner;

  Map<String, dynamic>? user;
  final _resetPasswordFormKey = GlobalKey<FormState>();

  final TextEditingController _newPasswordController = TextEditingController();

  Future<void> build() async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (
            context,
            setState,
          ) {
            return AlertDialog(
              actionsAlignment: MainAxisAlignment.start,
              title: const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 27.0,
                    ),
                    child: Text(
                      'Change Password',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              content: Container(
                width: 500.0,
                height: 250.0,
                margin: const EdgeInsets.only(
                  left: 20.00,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 0.0,
                  horizontal: 20.0,
                ),
                child: Scaffold(
                  body: Center(
                    child: Form(
                      key: _resetPasswordFormKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                              icon: Icon(
                                Icons.security,
                              ),
                              hintText: 'Enter New Password',
                              // labelText: 'Enter New Password',
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
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
                              icon: Icon(
                                Icons.security,
                              ),
                              labelText: 'Confirm Password',
                              // hintText: 'Confirm Password',
                            ),
                            onEditingComplete: _resetPassword,
                          ),
                        ],
                      ),
                    ),
                  ),
                  floatingActionButton: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: TextButton.icon(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: TextButton.styleFrom(
                              foregroundColor: Colors.red.shade900,
                              iconColor: Colors.red.shade900,
                              backgroundColor: Colors.redAccent.shade100
                          ),
                          icon: const Icon(Icons.backspace_outlined,),
                          label: const Text(
                            'Cancel',
                          ),
                        ),
                      ),
                      const SizedBox(width: 10.0,),
                      Expanded(
                        child: TextButton.icon(
                          onPressed: _resetPassword,
                          style: TextButton.styleFrom(
                              foregroundColor: Colors.green.shade900,
                              iconColor: Colors.green.shade900,
                              backgroundColor: Colors.greenAccent.shade100
                          ),
                          icon: const Icon(Icons.save_as,),
                          label: const Text(
                            'Confirm',
                          ),

                        ),
                      ),
                    ],
                  ),
                ),
              ),

            );
          },
        );
      },
    );
  }

  _resetPassword() async {
    if (_resetPasswordFormKey.currentState!.validate()) {
      final OverlayWidgets overlay = OverlayWidgets(
        context: context,
      );
      overlay.showOverlay(
        SnapShortStaticWidgets.snapshotWaitingIndicator(),
      );

      FocusScope.of(context).unfocus();
      user ??= Map<String, dynamic>.from(
        await jsonDecode(
          await SharedStorage.getString(SharedPrefs.loggedInUser) ?? '{}',
        ),
      );
      dynamic request = await User(user![JsonResponses.id]).set(
        password: _newPasswordController.text,
      );
      if (request.statusCode == 200 || request.statusCode == 201) {
        final SharedPreferences prefs = await preferences;

        String roleRoot = prefs.getString(SharedPrefs.roleRoot) ?? '';
        isOwner? navigate(roleRoot):
        dismiss();
        Alerts.toastMessage(message: 'Password Successfully Changed', positive: true,);
      } else if (request.statusCode == 401) {
        AuthenticateView.message = 'Token Invalid';
      } else {
        failedAlert();
      }
      overlay.dismissOverlay();
    }
  }

  failedAlert() => Alerts.flushbar(
        context: context,
        message: 'Failed To Reset',
        positive: false,
        popContext: true,
      );

  navigate(roleRoot) => Navigator.pushReplacementNamed(
        context,
        roleRoot,
      );

  dismiss() => Navigator.pop(context);
}
