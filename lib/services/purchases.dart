part of 'package:mawa_package/mawa_package.dart';

class Purchases {
  late String purchaseId;
  dynamic isValid;
  getAllLayBy() async {
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
            resource: Resources.layBy),
        negativeResponse: []);
  }

  static getSpecifLayBy({required String layById}) async {
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
            resource: '${Resources.layBy}/$layById'),
        negativeResponse: []);
  }

  createLayBy(
      {
      required String customerId,
      required String salesRepresentativeId,
      dynamic period,
      required dynamic productId}) async {
    return await NetworkRequests().securedMawaAPI(NetworkRequests.methodPost,
            resource: Resources.layBy,
            body: {
              JsonPayloads.customerId: customerId,
              JsonPayloads.salesRepresentativeId: salesRepresentativeId,
              JsonPayloads.productId: productId,
              JsonResponses.period: period
             }
            );

  }

  editLayBy(
      { dynamic status,
        dynamic statusReason,
        dynamic endDate,
        String ? layById
        }) async {
    return await NetworkRequests().securedMawaAPI(NetworkRequests.methodPut,
            resource:'${Resources.layBy}/$layById',
            body: {
              JsonPayloads.status: status,
              JsonPayloads.statusReason: statusReason,
              JsonPayloads.endDate: endDate,
            }
            );
  }

}
