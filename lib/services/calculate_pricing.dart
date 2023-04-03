part of 'package:mawa_package/mawa_package.dart';

class CalculatePricing{

  static calcPricing({
    required  body
  }) async {
    return await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPost,
        resource: Resources.calculate_pricing,
        body:body
    );

  }
}