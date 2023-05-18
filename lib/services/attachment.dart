part of 'package:mawa_package/mawa_package.dart';

class Attachment{
  Attachment(this.id);
  final String id;

  /// NEW BACKEND

  // /attachmentfile/ff808081882e714501882e8ea8f10001
  get() async {
    return await NetworkRequests(responseType: NetworkRequests.responseJson,).securedMawaAPI(
      NetworkRequests.methodGet,
      resource: '${Resources.attachment}/$id',
    );
  }

  // /attachmentfile
  //  {
  //   "file": "string"
  // }
  static attachBase64(Uint8List fileBytes) async {
    return await NetworkRequests(responseType: NetworkRequests.responseJson,).securedMawaAPI(
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
    return await NetworkRequests(responseType: Headers.jsonContentType,).securedMawaAPI(
      NetworkRequests.methodPost,
      resource: Resources.attachment,
      body:
      {
        JsonPayloads.id: id,
        JsonPayloads.uploadDate: uploadDate,
        JsonPayloads.uploadTime: uploadTime,
        JsonPayloads.uploadedBy: uploadedBy ?? User.loggedInUser[JsonResponses.username],
        JsonPayloads.downloadDate: downloadDate,
        JsonPayloads.downloadedBy: downloadedBy,
        JsonPayloads.file: '$file',
      },
    );
  }
}