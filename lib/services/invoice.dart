part of 'package:mawa_package/mawa_package.dart';

class Invoice{
  static createInvoice({
    String ? customer,
    String ? salesRepresentative,
    String ? dueDate,
    String ? invoiceDate,
    String ? paymentTerms,
    required Map<String, dynamic> pricing,
    required List<Map<String, dynamic>> item
  }) async{

    dynamic response=await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPost,
        resource: Resources.invoice,
        body: {
          JsonPayloads.customerId: customer,
          JsonPayloads.salesRepresentative: salesRepresentative,
          JsonPayloads.dueDate: dueDate,
          JsonPayloads.invoiceDate: invoiceDate,
          JsonPayloads.paymentTerms: paymentTerms,
          JsonPayloads.items:item,
          JsonPayloads.pricing:pricing
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