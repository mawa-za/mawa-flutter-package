part of 'package:mawa_package/mawa_package.dart';

class Vouchers{
  Vouchers({required this.id});
  final String id;


  getVouchers(String claimNo) async {
    return await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
        resource: Resources.vouchers,
        queryParameters: {
          QueryParameters.filter: QueryParameters.filterValue,
          QueryParameters.transactionLink: claimNo
        }

    ), negativeResponse: []);
  }

}