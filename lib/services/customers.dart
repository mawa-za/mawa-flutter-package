part of 'package:mawa_package/mawa_package.dart';
class Customers {
  late String customerId;
  // Customers(this.customerId);

  //Get All customers method
  getAllCustomers() async {
   return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
            resource: Resources.customer),
        negativeResponse: []);

  }

}
