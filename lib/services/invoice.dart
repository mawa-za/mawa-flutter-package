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
        resource: Resources.invoice,
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

  getInvoice(String id) async {
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: '${Resources.invoice}/$id',
        ),
        negativeResponse: {});
  }

  getInvoices() async {
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: Resources.invoice,
        ),
        negativeResponse: []);
  }

}