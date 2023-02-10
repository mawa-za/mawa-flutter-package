part of 'package:mawa_package/mawa_package.dart';

class PurchaseOrder{

  static createPurchaseOrder({
    String ? deliveryDate,
    String ? supplier,
    String ? product,
    String ? quantity,
  }) async{
    await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPost,
        resource: Resources.purchaseOrder,
        body: {
          JsonPayloads.supplier: supplier,
          JsonPayloads.deliveryDate: deliveryDate,
          JsonPayloads.items:[
            {
              JsonPayloads.product: product,
              JsonPayloads.quantity: quantity,
            }
          ],

        });
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