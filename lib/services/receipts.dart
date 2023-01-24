part of 'package:mawa_package/mawa_package.dart';

class Receipts {
  static List receiptsList = [];
  static Map receipt = {};
  static dynamic capturedBy;
  static dynamic collectedFunds;

  processReceipt(
      /*Map payment ,int paymentPeriod,*/ {dynamic reference,
      dynamic tenderType,
      dynamic amount}) async {
    // DeviceInfo info =
    DeviceInfo();

    Map payment = {
      QueryParameters.reference: '$reference',
      QueryParameters.amount: '$amount',
      QueryParameters.tenderType: '$tenderType',
      QueryParameters.terminalId: DeviceInfo.deviceData[DeviceInfo.imeiNo],
      QueryParameters.location: Location.address.toString(),
      QueryParameters.terminalType: DeviceInfo.deviceData[DeviceInfo.modelName],
    };

    return await NetworkRequests.decodeJson(await NetworkRequests()
        .securedMawaAPI(NetworkRequests.methodPost,
            resource: Resources.receipts, body: payment));
  }

  userProcessedReceipts(bool filter) async {
    String filterString;
    filter ? filterString = 'x' : filterString = '';

    receiptsList.clear();
    collectedFunds = 0.00;
    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: Resources.receipts,
        queryParameters: {
          QueryParameters.processedBy: User.loggedInUser[JsonResponses.id],
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
    // else{
    //  receiptsList = [];
    //  }
    return receiptsList;
  }

  receiptHistory(String referenceNo) async {
    receiptsList = [];
    // print('referenceNo'+referenceNo);
    List receipts = await NetworkRequests.decodeJson(await NetworkRequests()
        .securedMawaAPI(NetworkRequests.methodGet,
            resource: Resources.receipts,
            queryParameters: {QueryParameters.reference: referenceNo}));
    // receipts.runtimeType == List &&
    receipts.isNotEmpty ? receiptsList = receipts : receiptsList = [];
    return receiptsList;
  }

  getReceipt({required String receiptId}) async {
    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: '${Resources.receipts}/${receiptId ?? ''}');
    if (receiptId == '') {
      receiptsList =
          await NetworkRequests.decodeJson(response, negativeResponse: []);
      return receiptsList;
    } else {
      receipt =
          await NetworkRequests.decodeJson(response, negativeResponse: {});
      return receipt;
    }
  }

  // https://api-qas.mawa.co.za:8181/mawa-api/resources/receipts?checkoutId=CU0000000002
  getReceiptsForCashup(String cashupID) async {
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
            resource: Resources.receipts,
            queryParameters: {
              QueryParameters.checkoutId: cashupID,
            }),
        negativeResponse: []);
  }
}
