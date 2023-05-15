part of 'package:mawa_package/mawa_package.dart';

class Supplier {




  static getAll() async {
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: Resources.supplier,
        ),
        negativeResponse: []);
  }
   getSpecific(supplierID) async {
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: '${Resources.supplier}/$supplierID',
        ),
        negativeResponse: {});
  }


}