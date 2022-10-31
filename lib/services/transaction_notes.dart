import 'package:mawa_package/services.dart';
import 'package:http/http.dart' as http;

class TransactionNotes {
  TransactionNotes({this.transactionNote, this.transaction});
  final String? transaction;
  final String? transactionNote;

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
    return await NetworkRequests.decodeJson( await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
        resource: Resources.transactionNotes + '/' + transactionNote!));
  }

  getTransactionNotes() async {
    return await NetworkRequests.decodeJson( await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
        resource: Resources.transactionNotes,
        queryParameters: {QueryParameters.transaction: transaction}));
  }

  static createComment({required String transaction, required String type, required String comment, required String receiver}) async {
    dynamic note = createNote(value: comment, type: type, transaction: transaction);
    if(note.statusCode == 200 || note.statusCode == 201){
     dynamic notify = await Notification(id: transaction).sendCommentNotification(receiver);
     if(notify.statusCode == 200 || notify.statusCode == 201){
       return notify;
     }
     else{
       return http.Response('Comment created but notification failed',429);
     }
      }
    else{
      return note;
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