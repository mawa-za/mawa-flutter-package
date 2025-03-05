part of 'package:mawa_package/mawa_package.dart';

class Invoice{
  static createInvoice({
    String ? customer,
    String ? salesRepresentative,
    String ? dueDate,
    String ? invoiceDate,
    String ? paymentTerms,
    required Map<String, dynamic> pricing,
    required List<Map<String, dynamic>> item,
    String ? transactionID,
    String ? invoiceType
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
          JsonPayloads.pricing:pricing,
          JsonPayloads.transactionId:transactionID,
          JsonPayloads.invoiceType:invoiceType
        });
    return response;

  }

  static downloadMembershipInvoice(String? id) async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPost,
      resource: '${Resources.invoice}/$id/${Resources.invoicePdf}',
    );
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
  static deleteInvoice({required String invoiceId}) async {
    return await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodDelete, resource: '${Resources.invoice}/$invoiceId',
    ),
    );
  }


}