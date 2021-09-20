// ignore_for_file: avoid_print
part of mawa;

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class InternetConnection {
  bool shouldShowBanner = true;

void _enablePlatformOverrideForDesktop() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux)) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
}

String connectionStatus = 'Unknown';
final Connectivity _connectivity = Connectivity();
late StreamSubscription<ConnectivityResult> _connectivitySubscription;

Future<dynamic> initConnectivity() async {
  _connectivitySubscription =
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

ConnectivityResult? result;
  try {
    result = await _connectivity.checkConnectivity();
  } on PlatformException catch (e) {
    print('error ${e.toString()}');
  }

print('loooopj $result!');
  return _updateConnectionStatus(result!);
}

Future<void> _updateConnectionStatus(ConnectivityResult result) async {
  print('1');

  switch (result) {
    case ConnectivityResult.wifi:{
      connectionStatus = result.toString();
      _hideBanner();
    }
      break;

    case ConnectivityResult.mobile:{
      connectionStatus = result.toString();
      _hideBanner();}
      break;

    case ConnectivityResult.none:{
      print('2');
    connectionStatus = result.toString();
    _showBanner();
    }
      break;
    default:{
      connectionStatus = 'Failed to get connectivity.';
      _showBanner();}

      break;
  }
}



void _hideBanner() {
  shouldShowBanner = false;
}

  void _showBanner() {
  shouldShowBanner = true;
  }

  notification() {
    initConnectivity();
    if (shouldShowBanner) {
      return MaterialBanner(
          content: FutureBuilder(
            future: initConnectivity(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              Widget child;
              if (snapshot.connectionState == ConnectionState.done) {
                child = Container(
                  child: Center(
                    child: Text(connectionStatus),
                  ),
                );
              } else
                  child = Container();
                return child;
              },),
            actions: [Container()]);

}
  }
  notify(){
    // return      Fluttertoast.showToast(
    //     msg: connectionStatus,
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.CENTER,
    //     timeInSecForIosWeb: 10,
    //     backgroundColor: Colors.white,
    //     textColor: Colors.black,
    //     fontSize: 16.0);

  }
}