part of 'package:mawa_package/mawa_package.dart';

class AuthenticateView extends StatefulWidget {
  static const String id = 'Login';
  Widget? logo;
  static String? message;
  static Color messageColor = Colors.redAccent;
  late Function postAuthenticate;
  static dynamic response;
  AuthenticateView({super.key, route, required this.postAuthenticate, this.logo});

  @override
  State<AuthenticateView> createState() => _AuthenticateViewState();
}

class _AuthenticateViewState extends State<AuthenticateView> {
  late String username;
  late String password;
  dynamic usn;
  late Widget body;

  final _formKey = GlobalKey<FormState>();

  submitAuthenticationRequest() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        body = SnapShortStaticWidgets.snapshotWaitingIndicator(
            text: 'Authenticating...');
      });
      FocusScope.of(context).unfocus();

      User.username = username;
      User.password = password;
      AuthenticateView.response = await NetworkRequests().unsecuredMawaAPI(NetworkRequests.methodPost,
          resource: Resources.authenticate,
          payload: {
            "username": User.username,
            "password": User.password},
          context: context,);
      if (AuthenticateView.response.statusCode == 200) {
        widget.postAuthenticate();
      } else{
        Alerts.flushbar(context: context, message: 'Incorrect Login', positive: false);
      }
        setState(() {
          body = authenticate();
        });
    }
  }

  @override
  void initState() {
    body = authenticate();
    Tools.isTouchLocked = false;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    Tools.context = context;
    setLastPage(AuthenticateView.id);

    // preferences.then((SharedPreferences prefs) {
    //   return (prefs.setString(SharedPreferencesKeys.lastPage, Authenticate.id));
    // });
    return SafeArea(
      child: WillPopScope(
        onWillPop: () => Constants.promptExit(context),
        child: AbsorbPointer(
          absorbing: Tools.isTouchLocked,
          child: Scaffold(
            body: body,
          ),
        ),
      ),
    );
  }

  Widget authenticate() {
    return Center(
      child: ListView(
        children: [
          const SizedBox(
            height: 60.0,
          ),
          Flexible(child: widget.logo ?? Container(),),
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
                            AuthenticateView.message = '';
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
                          AuthenticateView.message = '';
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
            padding:
            const EdgeInsets.symmetric(vertical: 5.0, horizontal: 50.0),
            child: ElevatedButton(
              onPressed: () {
                submitAuthenticationRequest();
              },
              child: const Text('Login', style: TextStyle(fontSize: 20)),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
        ],
      ),
    );
  }
}