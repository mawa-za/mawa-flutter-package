part of 'package:mawa_package/mawa_package.dart';

class PurchaseOrder{

  static createPurchaseOrder({
    String ? dueDate,
    String ? customer,
    String ? product,
    String ? quantity,
  }) async{
    await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPost,
        resource: Resources.purchaseOrder,
        body: {
          JsonPayloads.customer: customer,
          JsonPayloads.dueDate: dueDate,
          JsonPayloads.items:[
            {
              JsonPayloads.product: product,
              JsonPayloads.quantity: quantity,
            }
          ],

        });
  }

  getSpurchaseOrder(String purchaseOrderID) async {
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: Resources.purchaseOrder + '/' + purchaseOrderID,
        ),
        negativeResponse: {});
  }

}