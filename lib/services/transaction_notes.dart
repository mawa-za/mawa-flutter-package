import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mawa_package/services.dart';
import 'package:http/http.dart' as http;
import 'notification.dart' as nt;

class TransactionNotes {
  TransactionNotes({this.transactionNote, this.transaction});
  final String? transaction;
  final String? transactionNote;
  String? note;
  // bool email = false;
  // bool sms = false;
  // List<String> items = ["email", "sms", "both"];
  // String selectedVal = '';
  // bool notifType = false;
  dynamic cont;

  static createNote(
      {required String value,
      required String type,
      required String transaction}) async {
    return await NetworkRequests().securedMawaAPI(NetworkRequests.methodPost,
        resource: Resources.transactionNotes,
        body: {
          JsonPayloads.value: value,
          JsonPayloads.type: type,
          JsonPayloads.transaction: transaction,
        });
  }

  getNote() async {
    return await NetworkRequests.decodeJson(await NetworkRequests()
        .securedMawaAPI(NetworkRequests.methodGet,
            resource: Resources.transactionNotes + '/' + transactionNote!));
  }

  getTransactionNotes() async {
    return await NetworkRequests.decodeJson(await NetworkRequests()
        .securedMawaAPI(NetworkRequests.methodGet,
            resource: Resources.transactionNotes,
            queryParameters: {QueryParameters.transaction: transaction}));
  }

  static createComment(
      {required String transaction,
      required String type,
      required String comment,
      required String receiver}) async {
    dynamic note =
        createNote(value: comment, type: type, transaction: transaction);
    if (note.statusCode == 200 || note.statusCode == 201) {
      dynamic notify =
          await nt.Notification(id: transaction).sendCommentNotification(receiver);
      if (notify.statusCode == 200 || notify.statusCode == 201) {
        return notify;
      } else {
        return http.Response('Comment created but notification failed', 429);
      }
    } else {
      return note;
    }
  }

  notePopup(BuildContext context) async  {
    final formKey = GlobalKey<FormState>();
    String? note;
    // notType = items[2];


    dynamic dlg = AwesomeDialog(
      context: context,
      dialogType: DialogType.QUESTION,
      dismissOnTouchOutside: false,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Information!',
      body: Form(
        key: formKey,
        child: TextFormField(
          decoration: Constants.textInputDecorations(
              'Provide A Comment', Icons.palette),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          onChanged: (n) {
            note = n;
          },
          onEditingComplete: () {},
        ),
      ),
      btnOk: TextButton(
        child: const Text('Submit'),
        onPressed: () {
          if (formKey.currentState!.validate()) {
            Navigator.of(context).pop();

          }
        },
      ),
      btnCancel: TextButton(
        child: const Text('Cancel'),
        onPressed: () {
          note = null;
          Navigator.of(context).pop();
        },
      ),
    );

    await dlg.show();
    if (note != null ) {
      this.note = note;
      return true; //Future.value(note?? '');
    } else {
      return false;
    }
  }



}

//part of mawa;
//
// class TransactionNotes {
//   TransactionNotes({this.transactionNote, this.transaction});
//   final String? transaction;
//   final String? transactionNote;
//
//   static createNote(
//       {required String value,
//       required String type,
//       required String transaction}) async {
//     dynamic resp = await NetworkRequests().securedMawaAPI(NetworkRequests.methodPost,
//         resource: Resources.transactionNotes,
//         body: {
//           JsonPayloads.value: value,
//           JsonPayloads.type: type,
//           JsonPayloads.transaction: transaction,
//         });
//     if(resp.statusCode == 200){
//       try{
//         return jsonDecode(resp);
//       }
//       catch(e){
//         print(e.toString());
//       }
//     }
//   }
//
//   getNote() async {
//     dynamic resp = await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
//         resource: Resources.transactionNotes + '/' + transactionNote!);
//     if(resp.statusCode == 200){
//       try{
//         return jsonDecode(resp);
//       }
//       catch(e){
//         print(e.toString());
//       }
//     }
//   }
//
//   getTransactionNotes() async {
//     dynamic resp = await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
//         resource: Resources.transactionNotes,
//         queryParameters: {QueryParameters.transaction: transaction});
//     if(resp.statusCode == 200){
//       try{
//         return jsonDecode(resp);
//       }
//       catch(e){
//         print(e.toString());
//       }
//     }
//   }
// }
