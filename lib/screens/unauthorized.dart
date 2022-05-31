import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/cupertino.dart';
import 'package:mawa_package/services/tools.dart';

class Unauthorized extends StatelessWidget {
  static const String id = 'Unauthorized';
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
                Text('You Are Not Authorized To Utilize This Application',
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
