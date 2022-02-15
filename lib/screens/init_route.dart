part of mawa;

class InitialRoute extends StatefulWidget {
  static const String id = 'Init Route';
  var className;
  InitialRoute({this.className});
  @override
  _InitialRouteState createState() => _InitialRouteState();
}

class _InitialRouteState extends State<InitialRoute> {
  late Widget body;
  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  future() async {
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    await ApkVersion().getApkInfo();
  }

  @override
  void initState() {
    // TODO: implement initState
    // FocusScope.of(context).unfocus();
    super.initState();
  }

  @override
  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      case ConnectivityResult.none:
        _connectionStatus = result.toString(); //);
        break;
      default:
        _connectionStatus = 'Failed to get connectivity.'; //);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    Tools.context = context;
    return WillPopScope(
      onWillPop: () => Constants.promptExit(context),
      child: AbsorbPointer(
        absorbing: Tools.isTouchLocked,
        child: Scaffold(
          body: FutureBuilder(
              future: future(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {

                  if(ApkVersion.apkUsable != null &&
                      ApkVersion.apkUsable == false) {
                    body = OutdatedAPK();
                  }
                      else{
                        if(_connectionStatus == ConnectivityResult.wifi.toString() ||
                        _connectionStatus == ConnectivityResult.mobile.toString()){
                        //   if(mawa.NetworkRequests.statusCode == 200){
                        //     body = DashBoard();
                          // }
                          // else{
                            body = widget.className;//Authenticate();
                          // }
                        }
                        else {
                          body = NoConnectionScreen(
                            redirect: InitialRoute.id,);
                        }

                  }
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  body =
                      SnapShortStaticWidgets.snapshotWaitingIndicator();
                } else if (snapshot.hasError) {
                  body = SnapShortStaticWidgets.snapshotError();
                } else {
                  body = SnapShortStaticWidgets.futureNoData();
                }

                return body;
              }),
        ),
      ),
    );
  }

  checkServer() {}
}
