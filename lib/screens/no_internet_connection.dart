part of mawa;

class NoConnectionScreen extends StatefulWidget {
  static const String id = 'Connectivity';

  NoConnectionScreen({required this.redirect});
  final String redirect;

  @override
  _NoConnectionScreenState createState() => _NoConnectionScreenState();
}

class _NoConnectionScreenState extends State<NoConnectionScreen> {
  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription!.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    ConnectivityResult? result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result!);
  }

  @override
  Widget build(BuildContext context) {
    Tools.context = context;
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        mainAxisAlignment:  MainAxisAlignment.center,
        crossAxisAlignment:  CrossAxisAlignment.stretch,
        children: [
          Flexible(child: Icon(Icons.network_check,size: 200.0,)),
          Text('$_connectionStatus', textAlign: TextAlign.center,),
        ],

      ),
    );
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
        Navigator.popAndPushNamed(context,widget.redirect);
        break;
      case ConnectivityResult.none:
        setState(() => _connectionStatus = 'No Network Connectivity');
        break;
      default:
        setState(() => _connectionStatus = 'Failed to get connectivity.');
        break;
    }
  }

}
