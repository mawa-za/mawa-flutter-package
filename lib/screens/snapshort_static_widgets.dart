part of mawa;

class SnapshotWaitingIndicator extends StatelessWidget {
static const String id = 'loading';
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          CircularProgressIndicator(),
          Text(
            'Please Wait',
              style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}

class SnapshotError extends StatelessWidget {
static const String id = 'error';
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          CircularProgressIndicator(),
          Text(
            'Please Wait',
              style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}

class SnapShortStaticWidgets {
  static const Color defaultColor = Colors.lightBlue;
  static const String defaultError =
      "Ops.., something error or error when get data.";
  static const String defaultErrorNoData = "No data found.";
  static const String defaultLoading = "Please wait...";
  static const String defaultLogoImage = "assets/images/logo.png";
  static const String defaultPrintLogoImage = "assets/images/print-logo.png";
  static const String defaultErrorImage = "assets/images/error_404.jpg";
  static const String defaultFont = "Pantone";

  static Widget snapshotWaitingIndicator({String? text,BuildContext? context}) {

    // final mediaQuery = MediaQuery.of(context!);
    const TextStyle style = TextStyle(color: Colors.black);

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const CircularProgressIndicator(),
          Text(
            text ?? defaultLoading,
            style: style,
          ),
        ],
      ),
    );
  }

  static Widget snapshotError() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        Center(child: Icon(Icons.error)),
        Text('Error encountered')
      ],
    );
  }

  static Widget snapshotWaitin() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Center(
              child: Icon(
            Icons.cached,
            size: 40.0,
          )),
          Text('Loading...')
        ]);
  }

  static Widget futureNoData({String? displayMessage}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.info,
            size: 40.0,
          ),
          Text(displayMessage ?? defaultErrorNoData),
        ],
      ),
    );
  }
}
