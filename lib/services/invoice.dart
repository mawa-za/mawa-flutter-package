part of 'package:mawa_package/mawa_package.dart';

class Invoice{

  static createInvoice({
    String ? customer,
    String ? dueDate,
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

}