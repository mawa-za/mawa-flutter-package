part of 'package:mawa_package/mawa_package.dart';

class SalesOrder {

  static createSaleOrder(
      {String? deliveryDate,
      String? customer,
      String? product,
      String? quantity,
      String? unitPrice,
      required List items}) async {
    await NetworkRequests().securedMawaAPI(NetworkRequests.methodPost,
        resource: Resources.salesOrder,
        body: {
          JsonPayloads.customer: customer,
          JsonPayloads.deliveryDate: deliveryDate,
          JsonPayloads.items: [
            {
              JsonPayloads.product: product,
              JsonPayloads.quantity: quantity,
              JsonPayloads.unitPrice: unitPrice
            }
          ],
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


}
