part of 'package:mawa_package/mawa_package.dart';

class Organisation {




  static getAll() async {
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: Resources.organization,
        ),
        negativeResponse: []);
  }
  getSpecific(orgD) async {
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: '${Resources.organization}/$orgD',
        ),
        negativeResponse: {});
  }


}