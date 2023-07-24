part of 'package:mawa_package/mawa_package.dart';

class Receipt {
  final String id;
  static List receiptsList = [];
  static dynamic collectedFunds;

  Receipt(this.id);

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
    String? invoiceNumber,
    String? membershipNumber,
    String? membershipPeriod,
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
      JsonPayloads.tenderType: tenderType,
      JsonPayloads.amount: amount,
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

  static userProcessedReceipts(bool filter) async {
    String filterString;
    filter ? filterString = 'x' : filterString = '';
    receiptsList.clear();
    collectedFunds = 0.00;
    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: Resources.receipts,
        queryParameters: {
          QueryParameters.processedBy:
              User.loggedInUser[JsonResponses.username],
          QueryParameters.filter: filterString
        });
    double funds = 0.0;
    if (response.statusCode == 200) {
      receiptsList = await NetworkRequests.decodeJson(response);
      for (int index = 0; index < receiptsList.length; index++) {
        // receiptsList.length > 0
        //     ?
        funds += double.parse(receiptsList[index][JsonResponses.amount])
            // : collectedFunds = 0.0
            ;
      }
    }
    collectedFunds = funds;
    return receiptsList;
  }

  static receiptHistory(String referenceNo) async {
    receiptsList = [];
    List receipts = await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
            resource: Resources.receipts,
            queryParameters: {QueryParameters.reference: referenceNo}),
        negativeResponse: []);
    receipts.isNotEmpty ? receiptsList = receipts : receiptsList = [];
    return receiptsList;
  }

  // https://api-qas.mawa.co.za:8181/mawa-api/resources/receipts/{id}
  get() async {
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
            resource: '${Resources.receipt}/$id'),
        negativeResponse: {});
  }

  // https://api-qas.mawa.co.za:8181/mawa-api/resources/receipts
  static getAll() async {
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
            resource: Resources.receipts),
        negativeResponse: []);
  }

  static search({
    String? receiptType,
    String? invoiceNumber,
    String? membershipNumber,
    String? membershipPeriod,
    String? tenderType,
    String? user,
  }) async {
    Map<String, dynamic> qaramParam = {};
    receiptType != null
        ? qaramParam[QueryParameters.receiptType] = receiptType
        : null;
    invoiceNumber != null
        ? qaramParam[QueryParameters.invoiceNumber] = invoiceNumber
        : null;
    membershipNumber != null
        ? qaramParam[QueryParameters.membershipNumber] = membershipNumber
        : null;
    membershipPeriod != null
        ? qaramParam[QueryParameters.membershipPeriod] = membershipPeriod
        : null;
    tenderType != null
        ? qaramParam[QueryParameters.tenderType] = tenderType
        : null;
    user != null ? qaramParam[QueryParameters.user] = user : null;
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: Resources.receipts,
        queryParameters: qaramParam,
      ),
      negativeResponse: [],
    );
  }

  // https://api-qas.mawa.co.za:8181/mawa-api/resources/receipts?checkoutId=CU0000000002
  static getReceiptsForCashup(String cashupID) async {
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
            resource: Resources.receipts,
            queryParameters: {
              QueryParameters.checkoutId: cashupID,
            }),
        negativeResponse: []);
  }
}
