part of 'package:mawa_package/mawa_package.dart';

class Prospect {




  static getAll() async {
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: Resources.prospects,
        ),
        negativeResponse: []);
  }
  static getSpecific(prospectID) async {
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: '${Resources.prospects}/$prospectID',
        ),
        negativeResponse: {});
  }


}