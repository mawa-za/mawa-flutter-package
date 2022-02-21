part of mawa;

class Unauthorized extends StatelessWidget {
  String? appName;
  Unauthorized({this.appName});

  @override
  Widget build(BuildContext context) {
    Tools.context = context;
    FocusScope.of(context).unfocus();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // backgroundColor: Colors.blueGrey,
          title: Text(
            appName ?? '',
            style: const TextStyle(
              // fontWeight: FontWeight.bold,
            ),
          ),),
        body: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.error_outline,
                  size: 20.0,),
                Text('You Are Not Authorized To Utilize This Mobile Application',
                  style: TextStyle(color: Colors.black,fontSize: 20.0),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
