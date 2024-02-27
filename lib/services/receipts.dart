part of 'package:mawa_package/mawa_package.dart';

class Receipt {
  final String id;
  static List receiptsList = [];
  static dynamic collectedFunds;

  Receipt(this.id);

  // https://dev.api.app.mawa.co.za/receipt
  // {
  //   "receiptType": "string",
  //   "invoiceNumber": "string",
  //   "membershipNumber": "string",
  //   "membershipPeriod": "string",
  //   "tenderType": "string",
  //   "amount": "string"
  // }
  static create({
    required String receiptType,
    required String transaction,
    String? invoiceNumber,
    String? membershipNumber,
    String? membershipPeriod,
    String? location,
    required String tenderType,
    required String amount,
  }) async {
    // // DeviceInfo info =
    // await DeviceInfo();
    // String? terminalType, terminalID, location;
    // if(DeviceInfo.deviceData !=null) {
    //   terminalID = '${DeviceInfo.deviceData![DeviceInfo.imeiNo] ?? ''}';
    //   terminalType = '${DeviceInfo.deviceData![DeviceInfo.modelName] ?? ''}';
    // }
    // location = Location.address;
    Map payment = {
      JsonPayloads.receiptType: receiptType,
      JsonPayloads.transaction: transaction,
      JsonPayloads.tenderType: tenderType,
      JsonPayloads.amount: amount,
      JsonPayloads.location: location,
    };
    invoiceNumber != null
        ? payment[JsonPayloads.invoiceNumber] = invoiceNumber
        : null;
    membershipPeriod != null
        ? payment[JsonPayloads.membershipNumber] = membershipNumber
        : null;
    membershipNumber != null
        ? payment[JsonPayloads.membershipPeriod] = membershipPeriod
        : null;

    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPost,
      resource: Resources.receipt,
      body: payment,
    );
  }

  // https://dev.api.app.mawa.co.za/receipt/ff8080818d9f8dc9018d9f94339c0001
  get() async {
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
            resource: '${Resources.receipt}/$id'),
        negativeResponse: {});
  }

  // https://dev.api.app.mawa.co.za/receipt
  static getAll() async {
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
            resource: Resources.receipt,),
        negativeResponse: [],);
  }

  // https://dev.api.app.mawa.co.za/receipt
  static search({
    String? receiptType,
    String? transaction,
    String? tenderType,
    String? user,
    bool? notCashed,
    String? location,
  }) async {
    Map<String, dynamic> qaramParam = {};
    receiptType != null
        ? qaramParam[QueryParameters.receiptType] = receiptType
        : null;
    transaction != null
        ? qaramParam[QueryParameters.transaction] = transaction
        : null;
    tenderType != null
        ? qaramParam[QueryParameters.tenderType] = tenderType
        : null;
    user != null
        ? qaramParam[QueryParameters.user] = user
        : null;
    location != null
        ? qaramParam[QueryParameters.location] = location
        : null;
    notCashed ??= false;
    if (notCashed) {
      qaramParam[QueryParameters.notCashed] = '$notCashed';
    }
    dynamic resp = await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: Resources.receipt,
        queryParameters: qaramParam,
      ),
      negativeResponse: [],
    );
    return resp;
  }

  // https://dev.api.app.mawa.co.za/receipt?transaction=ff8080818d9f8dc9018d9f94339c0001
  static getReceiptsForCashup(String cashupID) async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
          resource: Resources.receipt,
          queryParameters: {
            QueryParameters.checkoutId: cashupID,
          }),
      negativeResponse: [],
    );
  }
}
