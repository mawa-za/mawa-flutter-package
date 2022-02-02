part of mawa;


class Receipts {
  static List receiptsList = [];
  static List cashupsList = [];
  static Map receipt = {};
  static Map cashup = {};
  static dynamic capturedBy;
  static dynamic collectedFunds;

  processReceipt(
      /*Map payment ,int paymentPeriod,*/ {dynamic reference,
        dynamic tenderType,dynamic amount}) async {
    // DeviceInfo info =
    DeviceInfo();

    Map payment = {
      'reference': '$reference',
      'amount': '$amount',
      'tenderType':'$tenderType',
      'terminalId': DeviceInfo.platformImei,
      'location': Location.address.toString(),
      'terminalType': DeviceInfo.terminal.toString()
    };

    return await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(NetworkRequests.methodPost,
        resource: Resources.receipts, body: payment));
  }

  userProcessedReceipts(bool filter) async {
    String filterString;
    filter ? filterString = 'x' : filterString = '';

    receiptsList = [];
    receiptsList = await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: Resources.receipts,
        queryParameters: {
          QueryParameters.processedBy: User.loggedInUser[JsonResponses.id],
          QueryParameters.filter: filterString
        }));
  }

  receiptHistory(String referenceNo) async {
    receiptsList = [];
    // print('referenceNo'+referenceNo);
    List receipts = await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: Resources.receipts,
        queryParameters: {QueryParameters.reference: referenceNo}));
    print(receipts.runtimeType);
    // receipts.runtimeType == List &&
    receipts.isNotEmpty ? receiptsList = receipts : receiptsList = [];
    print(receiptsList.length.toString() + ' long ');
  }

  processCashup() async {
    return await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(NetworkRequests.methodPost,
        resource: Resources.cashup));
  }

  getReceipt({required String receiptId}) async {
    // receiptId != null
    //     ?
    receipt = await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(
                NetworkRequests.methodGet,
                resource: '${Resources.receipts}/$receiptId') )??
        {}
    ;
        // : receipt = {};
  }

  getCashupCollection({required String processor}) async {
    cashupsList = await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: Resources.cashup,
        queryParameters: {QueryParameters.processor: processor}));
  }

  getCashup({required String cashupId}) async {
    dynamic response;
    // if (cashupId != null) {
      response =  await NetworkRequests().securedMawaAPI(
            NetworkRequests.methodGet,
            resource: '${Resources.cashup}/$cashupId',
          ) ??
          {};
      // response.runtimeType != List && response.runtimeType != String
      response.statusCode == 200
          ? cashup = await NetworkRequests.decodeJson(response)??
          {}
          : cashup = {};
    // } else {
    //   cashup = {};
    // }
    // cashup.runtimeType ;
  }
}

