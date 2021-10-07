part of mawa;

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
          JsonPayloadKeys.value: value,
          JsonPayloadKeys.type: type,
          JsonPayloadKeys.transaction: transaction,
        });
  }

  getNote() async {
    return await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
        resource: Resources.transactionNotes + '/' + transactionNote!);
  }

  getTransactionNotes() async {
    return await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
        resource: Resources.transactionNotes,
        queryParameters: {QueryParameters.transaction: transaction});
  }
}
