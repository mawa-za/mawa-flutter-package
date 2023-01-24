part of 'package:mawa_package/mawa_package.dart';

class Deposits {

//  https://api-qas.mawa.co.za:8181/mawa-api/resources/deposits?cashupId=CU0000000002
  getDeposits(String id) async {
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: Resources.deposits,
          queryParameters: {
            QueryParameters.cashupId: id,
          },
        ),
        negativeResponse: []);
  }
}
