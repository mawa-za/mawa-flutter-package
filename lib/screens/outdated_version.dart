import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mawa/services/tools.dart';

class OutdatedAPK extends StatelessWidget {
  static const id = 'Outdated APK';
  /*final*/ String? appName;
  /*const*/ OutdatedAPK({this.appName}/*{Key key}) : super(key: key*/);

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
                Text('Sorry this version is outdated or not suitable for use. \n Please visit your app store to update iit or consult your system administrator',
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
