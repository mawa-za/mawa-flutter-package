part of 'package:mawa_package/mawa_package.dart';

class PricingEngine{

  static calcPricing({
    double totalExcludingVat =0,
    double totalIncludingVat =0,
    double discountAmount =0,
    double discountPercentage =0,
    double vatPercentage =0,
    double vatAmount =0,
    required List<Map<String,dynamic>> items

  }) async {
    return await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPost,
        resource:Resources.pricingEngine,
        body:{
          JsonPayloads.totalExcVat:totalExcludingVat,
          JsonPayloads.totalIncVat:totalIncludingVat,
          JsonPayloads.discountAmount:discountAmount,
          JsonPayloads.discountPercentage:discountAmount,
          JsonPayloads.vatpercentage:vatPercentage,
          JsonPayloads.vatamount:vatAmount,
          JsonPayloads.items:items,
        }
    );

  }

}