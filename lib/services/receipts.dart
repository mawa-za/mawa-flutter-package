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
    Map payment = {
      'reference': '$reference',
      'amount': '$amount',
      'tenderType':'$tenderType',
      'terminalId': DeviceInfo.platformImei,
      'location': Location.address,
      'terminalType': DeviceInfo.terminal.toString()
    };

    return await NetworkRequests().securedMawaAPI(NetworkRequests.methodPost,
        resource: Resources.receipts, body: payment);
  }

  userProcessedReceipts(bool filter) async {
    String filterString;
    filter ? filterString = 'x' : filterString = '';

    receiptsList = [];
    receiptsList = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: Resources.receipts,
        queryParameters: {
          'processedBy': User.loggedInUser[JsonResponses.id],
          'filter': filterString
        });
  }

  receiptHistory(String referenceNo) async {
    receiptsList = [];
    // print('referenceNo'+referenceNo);
    List receipts = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: Resources.receipts,
        queryParameters: {'reference': referenceNo});
    print(receipts.runtimeType);
    // receipts.runtimeType == List &&
    receipts.isNotEmpty ? receiptsList = receipts : receiptsList = [];
    print(receiptsList.length.toString() + ' long ');
  }

  processCashup() {
    return NetworkRequests().securedMawaAPI(NetworkRequests.methodPost,
        resource: Resources.cashup);
  }

  getReceipt({required String receiptId}) async {
    receiptId != null
        ? receipt = await NetworkRequests().securedMawaAPI(
                NetworkRequests.methodGet,
                resource: '${Resources.receipts}/$receiptId') ??
            {}
        : receipt = {};
  }

  getCashupCollection() async {
    cashupsList = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: Resources.cashup,
        queryParameters: {'processor': 'me'});
  }

  getCashup({required String cashupId}) async {
    dynamic response;
    if (cashupId != null) {
      response = await NetworkRequests().securedMawaAPI(
            NetworkRequests.methodGet,
            resource: '${Resources.cashup}/$cashupId',
          ) ??
          {};
      response.runtimeType != List && response.runtimeType != String
          ? cashup = response
          : cashup = {};
    } else {
      cashup = {};
    }
    // cashup.runtimeType ;
  }
}

