part of 'package:mawa_package/mawa_package.dart';

class Attachment {
  Attachment(this.id){
    resource = '${Resources.attachment}/$id';
  }
  final String id;
  late final String resource;

  /// NEW BACKEND

  // /attachmentfile/{id}
  get() async {
    return
      await NetworkRequests(
        responseType: NetworkRequests.responseJson,
      ).securedMawaAPI(
        NetworkRequests.methodGet,
        resource: resource,
    );
  }

  // /attachment?transaction={transactionId}
  static getForTransaction(String transactionId) async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests(
        responseType: NetworkRequests.responseJson,
      ).securedMawaAPI(NetworkRequests.methodGet,
          resource: Resources.attachment,
          queryParameters: {
            QueryParameters.objectId: transactionId,
          }),
      negativeResponse: [],
    );
  }

  // /attachment
  //  {
  //   "file": "string",
  //   "documentType": "string",
  //   "objectType": "string",
  //   "objectId": "string"
  // }
  static create(
    Uint8List fileBytes, {
    required String objectId,
    required String objectType,
    required String documentType,
    required String extension,
  }) async {
    dynamic base = base64.encode(fileBytes);
    return await NetworkRequests(
      responseType: NetworkRequests.responseJson,
    ).securedMawaAPI(
      NetworkRequests.methodPost,
      resource: Resources.attachment,
      body: {
        JsonPayloads.file: base.toString(),
        JsonPayloads.documentType: documentType,
        JsonPayloads.extension: extension,
        JsonPayloads.objectType: objectType,
        JsonPayloads.objectId: objectId,
      },
    );
  }


  // /attachment/{id}
  delete() async {
    return await NetworkRequests(
      responseType: NetworkRequests.responseJson,
    ).securedMawaAPI(NetworkRequests.methodDelete,
        resource:resource,
        );
  }
}
