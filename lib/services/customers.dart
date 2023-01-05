
part of 'package:mawa_package/mawa_package.dart';

class Customers {
  static List customer = [];

  getAllCustomers() async {
  customer = await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodGet,
      resource: Resources.customers),
      negativeResponse: []);

      return customer;
  }


}