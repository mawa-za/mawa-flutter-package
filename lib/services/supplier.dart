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
  static getSpecific(prospectID) async {
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: '${Resources.supplier}/$prospectID',
        ),
        negativeResponse: {});
  }


}