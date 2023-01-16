part of 'package:mawa_package/mawa_package.dart';

class Cashups{

  static List cashupsList = [];
  static Map cashup = {};
  
  getCashupCollection({required String processor}) async {
    cashupsList = await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: Resources.cashup,
        queryParameters: {QueryParameters.processor: processor}));
    return cashupsList;
  }

  getCashup({required String cashupId}) async {
    dynamic response;
    // if (cashupId != null) {
    response =  await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodGet,
      resource: '${Resources.cashup}/$cashupId',
    ) ??
        {};
    // response.runtimeType != List && response.runtimeType != String
    response.statusCode == 200
        ? cashup = await NetworkRequests.decodeJson(response)??
        {}
        : cashup = {};
    // } else {
    //   cashup = {};
    // }
    // cashup.runtimeType ;
    return cashup;
  }

  processCashup() async {
    return await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(NetworkRequests.methodPost,
        resource: Resources.cashup));
  }

}