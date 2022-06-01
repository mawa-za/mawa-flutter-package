import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mawa_package/services/globals.dart';
import 'package:mawa_package/services/keys.dart';
import 'package:mawa_package/services/network_requests.dart';
import 'package:mawa_package/services/tools.dart';
import 'package:mawa_package/services/user.dart';
import 'package:mawa_package/screens/alerts.dart';

class Authenticate extends StatefulWidget {
  static const String id = 'Login';
  static String? message;
  static Color messageColor = Colors.redAccent;
  static late VoidCallback postAuthenticate;

  Authenticate({route, required VoidCallback afterAuthorization}){
    redirect = route;
    postAuthenticate = afterAuthorization;
  }

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  late String username;
  late String password;
  dynamic usn;

  final _formKey = GlobalKey<FormState>();

  submitAuthenticationRequest() async {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      Alerts.flushbar(message: 'Please Wait', context: context, showProgressIndicator: true);

      User.username = username;
      User.password = password;
      await NetworkRequests().unsecuredMawaAPI(NetworkRequests.methodPost,
          resource: Resources.authenticate,
          payload: {
            "userID": User.username,
            "password": User.password},
          context: context,
          direct: redirect, postAuthenticate: Authenticate.postAuthenticate);
    }
    setState(() {

    });
  }

  Future<bool> _promptExit(BuildContext c)  async {

    bool? canExit;

    dynamic dlg =

    AwesomeDialog(
      context: context,
      dialogType: DialogType.QUESTION,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Warning!',
      desc: 'Are You Sure You Want To Exit?',
      btnOk: TextButton(
        child: const Text('Yes'),
        onPressed: () {
          canExit = true;
          Navigator.pop(c, canExit!);
        },
      ),
      btnCancel:TextButton(
        child: const Text('No'),
        onPressed: () {
          canExit = false;
          Navigator.pop(c, canExit!);
        },
      ),

    );

    await dlg.show();
    return Future.value(canExit!);
  }

  @override
  void initState() {
    Tools.isTouchLocked = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Tools.context = context;
    setLastPage(Authenticate.id);

    // preferences.then((SharedPreferences prefs) {
    //   return (prefs.setString(SharedPreferencesKeys.lastPage, Authenticate.id));
    // });
    return SafeArea(
      child: WillPopScope(
        onWillPop: () => _promptExit(context),
        child: AbsorbPointer(
          absorbing: Tools.isTouchLocked,
          child: Scaffold(
            body: Center(
                      child: ListView(
                children: [
                  const SizedBox(
                      height: 60.0,
                  ),
                  const
                  // Flexible(child:
                  Icon(Icons.calendar_today,size: 70,),
                  // ),
                  Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15.0,
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50.0, vertical: 20.0),
                              child: TextFormField(
                                  autofocus: true,
                                  textInputAction: TextInputAction.next,
                                  decoration: const InputDecoration(
                                    icon: Icon(Icons.account_circle),
                                    labelText: 'Username',
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please Enter Username';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      usn = {};
                                      Authenticate.message = '';
                                      username = value;
                                    });
                                  }),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50.0, vertical: 20.0),
                              child: TextFormField(
                                textInputAction: TextInputAction.done,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.lock),
                                  labelText: 'Password',
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    Authenticate.message = '';
                                    password = value;
                                  });
                                },
                                onEditingComplete: () => submitAuthenticationRequest(),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'enter password';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            MaterialButton(
                              onPressed: () {
                                Tools().forgotPasswordPopup();
                              },
                              child: const Text(
                                'Forgot username or password?',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.blue,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                          ],
                        ),
                      ),
                  ),
                  Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 50.0),
                      child: ElevatedButton(
                        onPressed: () {
                          submitAuthenticationRequest();
                        },
                        child:
                        const Text('Login', style: TextStyle(fontSize: 20)),
                      ),
                  ),
                  const SizedBox(
                      height: 10.0,
                  ),
                ],
              ),
                    ),
          ),
        ),
      ),
    );
  }

}

