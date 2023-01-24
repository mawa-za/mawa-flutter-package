part of 'package:mawa_package/mawa_package.dart';

class Cashups {
  static List cashupsList = [];
  static Map cashup = {};

  getCashupCollection({required String processor}) async {
    cashupsList = await NetworkRequests.decodeJson(await NetworkRequests()
        .securedMawaAPI(NetworkRequests.methodGet,
            resource: Resources.cashup,
            queryParameters: {QueryParameters.processor: processor}));
    return cashupsList;
  }

  getCashup({required String cashupId}) async {
    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: '${Resources.cashup}/${cashupId ?? ''}');
    if (cashupId == '') {
      cashupsList =
          await NetworkRequests.decodeJson(response, negativeResponse: []);
      return cashupsList;
    } else {
      cashup = await NetworkRequests.decodeJson(response, negativeResponse: {});
      return cashup;
    }
  }

  processCashup() async {
    return await NetworkRequests()
        .securedMawaAPI(NetworkRequests.methodPost, resource: Resources.cashup);
  }

}
