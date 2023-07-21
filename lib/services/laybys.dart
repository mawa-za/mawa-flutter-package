part of 'package:mawa_package/mawa_package.dart';

class LayBys {
  late String purchaseId;
  dynamic isValid;
  getAllLayBy({String ? customerId, String ? status,String ? endDate,String ? salesRepresentative,String ? number}) async {
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
            resource: Resources.layBy,
          queryParameters: {
            QueryParameters.customerId: customerId,
            QueryParameters.status: status,
            QueryParameters.endDate: endDate,
            QueryParameters.salesRepresentative: salesRepresentative,
            QueryParameters.number: number,
          },),
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
