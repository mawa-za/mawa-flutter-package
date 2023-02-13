part of 'package:mawa_package/mawa_package.dart';

class Invoice{

  static createInvoice({
    String ? customer,
    String ? dueDate,
    required List<Map<dynamic,String>> item
  }) async{
    await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPost,
        resource: Resources.invoice,
        body: {
          JsonPayloads.customer: customer,
          JsonPayloads.dueDate: dueDate,
          JsonPayloads.items:item

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