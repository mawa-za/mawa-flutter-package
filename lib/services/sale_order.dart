part of 'package:mawa_package/mawa_package.dart';

class SalesOrder {

  static createSaleOrder(
      {String? deliveryDate,
        String? customer,
        required List<Map<dynamic,String>> item}) async {
    await NetworkRequests().securedMawaAPI(NetworkRequests.methodPost,
        resource: Resources.salesOrder,
        body: {
          JsonPayloads.customer: customer,
          JsonPayloads.deliveryDate: deliveryDate,
          JsonPayloads.items: item
        });
  }

  getSaleOrder(String id) async {
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: '${Resources.salesOrder}/$id',
        ),
        negativeResponse: {});
  }

  getAllSalesOrders() async {
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: Resources.salesOrder,
        ),
        negativeResponse: {});
  }


}
