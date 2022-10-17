import 'package:another_flushbar/flushbar.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mawa_package/services/tools.dart';
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

  ///MIGHT NOT WORK
  static toast({required BuildContext context,IconData? iconData,bool? positive, required String message,}) {
    FToast ftoast = FToast();
    Duration? duration;
    Color? backgroundColor;
    Color? textColor;


    if (positive == null){
      duration = const Duration(seconds: 3);
      backgroundColor = Colors.white;
      textColor = Colors.black;

    }
    else if(positive){
      duration = const Duration(seconds: 5);
      backgroundColor = Colors.green[100]!;
      textColor = Colors.green;
      iconData = Icons.check;
    }
    else if(!positive) {
      duration = const Duration(seconds: 10);
      backgroundColor = Colors.red[100]!;
      textColor = Colors.red;
      iconData = Icons.cancel_outlined;
    }
    else{
      duration = const Duration(seconds: 3);
      backgroundColor = Colors.white;
      textColor = Colors.black;
    }

    ftoast.showToast(
      child:  Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            color: backgroundColor,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(iconData),
              const SizedBox(
                width: 12.0,
              ),
              Text(message, style: TextStyle(color: textColor),),
            ],
          ),
        ),
      gravity: ToastGravity.CENTER,
      toastDuration: duration,
    );
  }

  static toastMessage({bool? positive, required String message,Toast length = Toast.LENGTH_SHORT}) {

    Color? backgroundColor;
    Color? textColor;


    if (positive == null){
      backgroundColor = Colors.white;
      textColor = Colors.black;

    }
    else if(positive){
      backgroundColor = Colors.green[100]!;
      textColor = Colors.green;
    }
    else if(!positive) {
      backgroundColor = Colors.red[100]!;
      textColor = Colors.red;
      length = Toast.LENGTH_LONG;
    }
    else{
      backgroundColor = Colors.white;
      textColor = Colors.black;
    }

    Fluttertoast.showToast(
      gravity: ToastGravity.CENTER,
      toastLength: length,
      msg: message,
      timeInSecForIosWeb: 3,
      backgroundColor: backgroundColor,
      textColor: textColor,
    );
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

  popup(context,{message,title}) {
    return AwesomeDialog(
        context:  context,
        title: title ?? '',
        body: Text('$message'),
        btnOk: DialogButton(child: const Text('OK', style: TextStyle(color: Colors.white),),
            onPressed: (){
              openAppSettings();
            },
            color: Colors.blueGrey)

      // buttons: [
      //     DialogButton(child: const Text('OK', style: TextStyle(color: Colors.white),), onPressed: ()=> Navigator.of(context).pop(), color: Colors.blueGrey)
      //   ]
    ).show();
  }
}