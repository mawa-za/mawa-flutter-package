part of 'package:mawa_package/mawa_package.dart';

class Invoice{

  static createInvoice({
    String ? customer,
    String ? dueDate,
    String ? invoiceDate,
    String ? paymentTerms,
    required List<Map<dynamic,String>> item
  }) async{

    dynamic response=await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPost,
        resource: Resources.invoice,
        body: {
          JsonPayloads.customerId: customer,
          JsonPayloads.dueDate: dueDate,
          JsonPayloads.items:item

        });
    return response;

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