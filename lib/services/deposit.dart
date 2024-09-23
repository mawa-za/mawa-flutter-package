part of 'package:mawa_package/mawa_package.dart';

class Deposit {
  final String id;
  late final String path;

  Deposit(this.id) {
    path = '${Resources.deposits}/$id';
  }

  static search({
    String? createdBy,
    String? status,
    String? createdOn,
  }) async {
    return NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: Resources.deposit,
        queryParameters: {
          QueryParameters.createdBy: createdBy,
          QueryParameters.status: status,
          QueryParameters.createdOn: createdOn,
        },
      ),
      negativeResponse: [],
    );
  }

  static create({
    required String transactionID,
    required double amount,
  }) async {
    return await NetworkRequests().securedMawaAPI(NetworkRequests.methodPost,
        resource: Resources.deposit,
        body: {
          JsonPayloads.amount: '$amount',
          JsonPayloads.transactionIdLink: transactionID,
        },);
  }
  static attachmentDepositCreate(Uint8List fileBytes,{
    required String transactionID,
    required double amount,
    required String extension,
    required String documentType,
    required String objectType

  }) async {
    dynamic fileString = base64.encode(fileBytes);
    return await NetworkRequests().securedMawaAPI(NetworkRequests.methodPost,
      resource: '${Resources.deposit}/${Resources.depositAttachment}',
      body: {
        JsonPayloads.amount: '$amount',
        JsonPayloads.transactionIdLink: transactionID,
        JsonPayloads.file: fileString.toString(),
        JsonPayloads.extension: extension,
        JsonPayloads.documentType: documentType,
        JsonPayloads.objectType: objectType,

      },);
  }

  get() async {
    return NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: path,
      ),
      negativeResponse: {},
    );
  }

  static getForTransaction(String transactionLinkId) async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: '${Resources.deposit}/${Resources.transactionLink}',
        queryParameters: {
          QueryParameters.transactionLinkId: transactionLinkId,
        }
      ),
      negativeResponse: [],
    );
  }

  delete() async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodDelete,
      resource: path,
    );
  }
}
