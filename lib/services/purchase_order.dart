part of 'package:mawa_package/mawa_package.dart';

class PurchaseOrder {
  static createPurchaseOrder(
      {String? deliveryDate,
      String? supplier,
      required List<Map<dynamic, String>> item}) async {
    dynamic response= await NetworkRequests().securedMawaAPI(NetworkRequests.methodPost,
        resource: Resources.purchaseOrder,
        body: {
          JsonPayloads.supplier: supplier,
          JsonPayloads.deliveryDate: deliveryDate,
          JsonPayloads.items: item,
        });
    return response;
  }

  static getAllPurchaseOrders() async {
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
            resource: Resources.purchaseOrder),
        negativeResponse: []);
  }

  getPurchaseOrder(String purchaseOrderID) async {
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: '${Resources.purchaseOrder}/$purchaseOrderID',
        ),
        negativeResponse: {});
  }
}
