part of 'package:mawa_package/mawa_package.dart';

class Attachment {
  Attachment(this.id);
  final String id;

  /// NEW BACKEND

  // /attachmentfile/{id}
  get() async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests(
        responseType: NetworkRequests.responseJson,
      ).securedMawaAPI(
        NetworkRequests.methodGet,
        resource: '${Resources.attachment}/$id',
      ),
      negativeResponse: '',
    );
  }

  // /attachment/transaction/{transactionId}
  static getForTransaction(String transactionId) async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests(
        responseType: NetworkRequests.responseJson,
      ).securedMawaAPI(
        NetworkRequests.methodGet,
        resource:
            '${Resources.attachment}/${Resources.transaction}/$transactionId',
      ),
      negativeResponse: [],
    );
  }

  // /attachmentfile
  //  {
  //   "file": "string"
  // }
  static attachBase64(Uint8List fileBytes) async {
    return await NetworkRequests(
      responseType: NetworkRequests.responseJson,
    ).securedMawaAPI(
      NetworkRequests.methodPost,
      resource: Resources.attachment,
      body: {
        JsonPayloads.file: base64.encode(fileBytes),
      },
    );
  }

  // /attachment
  //{
  //   "id": "string",
  //   "uploadDate": "string",
  //   "uploadTime": "string",
  //   "uploadedBy": "string",
  //   "downloadDate": "string",
  //   "downloadedBy": "string",
  //   "file": "string"
  // }
  static attachFile({
    String? id,
    required String uploadDate,
    required String uploadTime,
    String? uploadedBy,
    String? downloadDate,
    String? downloadTime,
    String? downloadedBy,
    required dynamic file,
  }) async {
    return await NetworkRequests(
      responseType: Headers.jsonContentType,
    ).securedMawaAPI(
      NetworkRequests.methodPost,
      resource: Resources.attachment,
      body: {
        JsonPayloads.id: id,
        JsonPayloads.uploadDate: uploadDate,
        JsonPayloads.uploadTime: uploadTime,
        JsonPayloads.uploadedBy:
            uploadedBy ?? User.loggedInUser[JsonResponses.username],
        JsonPayloads.downloadDate: downloadDate,
        JsonPayloads.downloadedBy: downloadedBy,
        JsonPayloads.file: '$file',
      },
    );
  }

  // /attachment/{id}/partner
  // {
  //   "partner": "string",
  //   "fileType": "string"
  // }
  transactionLink(
      {required String transaction, required String fileType}) async {
    return await NetworkRequests(
      responseType: NetworkRequests.responseJson,
    ).securedMawaAPI(NetworkRequests.methodPost,
        resource: '${Resources.attachment}/$id/${Resources.partner}',
        body: {
          JsonPayloads.transaction: transaction,
          JsonPayloads.fileType: fileType
        });
  }

  // /attachment/{id}/partner
  // {
  //   "partner": "string",
  //   "fileType": "string"
  // }
  partnerLink({required String transaction, required String fileType}) async {
    return await NetworkRequests(
      responseType: NetworkRequests.responseJson,
    ).securedMawaAPI(NetworkRequests.methodPost,
        resource: '${Resources.attachment}/$id/${Resources.transaction}',
        body: {
          JsonPayloads.transaction: transaction,
          JsonPayloads.fileType: fileType
        });
  }

  // /attachment/transaction/{transactionId}?fileType={fileType}
  deleteFromTransaction(
      {required String transactionId, required String fileType}) async {
    return await NetworkRequests(
      responseType: NetworkRequests.responseJson,
    ).securedMawaAPI(NetworkRequests.methodDelete,
        resource:
            '${Resources.attachment}/${Resources.transaction}/$transactionId',
        queryParameters: {
          QueryParameters.fileType: fileType,
        });
  }
}
