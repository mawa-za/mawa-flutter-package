import 'package:another_flushbar/flushbar.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mawa/services/tools.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:permission_handler/permission_handler.dart';

class Alerts{


  static flushbar({required BuildContext context, bool? positive, required String message, bool popContext = false, bool showProgressIndicator = false}) {

    late Duration duration;
    if(popContext){
      Navigator.of(Tools.context).pop();
    }
    Color? backgroundColor;
    Color? textColor;


    if (positive == null){
      duration = const Duration(seconds: 5);
      backgroundColor = Colors.blueGrey;
      textColor = Colors.black;
    }
    else if(positive){
      duration = const Duration(seconds: 5);
      backgroundColor = Colors.green[100]!;
      textColor = Colors.green;
    }
    else if(!positive) {
      duration = const Duration(seconds: 20);
      backgroundColor = Colors.red[100]!;
      textColor = Colors.red;
    }
    else{
      duration = const Duration(seconds: 5);
      backgroundColor = Colors.blueGrey;
      textColor = Colors.black;
    }
    return Flushbar(
      duration: duration,
      message: message,
      messageColor: textColor,
      backgroundColor: backgroundColor,
      showProgressIndicator:  showProgressIndicator,
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      onTap: (_) => Navigator.of(Tools.context).pop(),
    ).show(context);
  }
  static Future<bool> exitPrompt(BuildContext context)  async {

    bool? canExit;

    dynamic dlg =

    AwesomeDialog(
      onDissmissCallback: (O){print('hello');},
      context: context,
      dialogType: DialogType.QUESTION,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Warning!',
      desc: 'Are You Sure You Want To Exit?',
      btnOk: TextButton(
        child: const Text('Yes'),
        onPressed: () {
          canExit = true;
          Navigator.pop(context, canExit!);
        },
      ),
      btnCancel:TextButton(
        child: const Text('No'),
        onPressed: () {
          canExit = false;
          Navigator.pop(context, canExit!);
        },
      ),

    );

    await dlg.show();
    return Future.value(canExit!);
  }


  openPopup(context, {message,title}) {
    return AwesomeDialog(
        context: context,
        title: title ?? '',
        body: Text('$message'),
        btnOk: DialogButton(child: const Text('OK', style: TextStyle(color: Colors.white)), onPressed: ()=> Navigator.of(context).pop(), color: Colors.blueGrey)
    ).show();
  }

  openPop(context, {message,title}) {
    return AwesomeDialog(
        context: context,
        title: title ?? '',
        body: Text('$message'),
        btnOk: DialogButton(child: const Text('OK', style: TextStyle(color: Colors.white),), onPressed: ()=> openAppSettings(), color: Colors.blueGrey)
    ).show();
  }

  popup(context, {message,title}) {
    return AwesomeDialog(
        context: context,
        title: title ?? '',
        body: Text('$message'),
        // buttons: [
        //   DialogButton(child: const Text('OK', style: TextStyle(color: Colors.white),), onPressed: ()=> Navigator.of(context).pop(), color: Colors.blueGrey)
        // ]
    ).show();
  }
}