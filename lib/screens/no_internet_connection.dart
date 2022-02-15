part of mawa;

class NoConnectionScreen extends StatefulWidget {
  static const String id = 'Connectivity';

  String connectionStatus = 'Unknown';
  final Connectivity connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? connectivitySubscription;

  NoConnectionScreen({required this.redirect});
  final String redirect;

  @override
  _NoConnectionScreenState createState() => _NoConnectionScreenState();
}

class _NoConnectionScreenState extends State<NoConnectionScreen> {

  @override
  void initState() {
    super.initState();
    initConnectivity();
    widget.connectivitySubscription =
        widget.connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    widget.connectivitySubscription!.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    ConnectivityResult? result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await widget.connectivity.checkConnectivity();
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
    FocusScope.of(context).unfocus();
    Tools.context = context;
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        mainAxisAlignment:  MainAxisAlignment.center,
        crossAxisAlignment:  CrossAxisAlignment.stretch,
        children: [
          const Flexible(child: Icon(Icons.network_check,size: 200.0,)),
          Text('${widget.connectionStatus} ', textAlign: TextAlign.center,),
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
        setState(() => widget.connectionStatus = 'No Network Connectivity');
        break;
      default:
        setState(() => widget.connectionStatus = 'Failed to get connectivity.');
        break;
    }
  }

}
