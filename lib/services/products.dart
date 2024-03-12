part of 'package:mawa_package/mawa_package.dart';

class Product {
  Product(this.id) {
    resource = '${Resources.product}/$id';
  }
  late String resource;
  final String id;

  static search({String? category, String? code}) async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: Resources.product,
        queryParameters: {
          JsonPayloads.category: category,
          JsonPayloads.code: code,
        },
      ),
    ); //
  }

  static getAll() async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: Resources.product,
      ),
      negativeResponse: [],
    );
  }

  get() async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: resource,
      ),
      negativeResponse: {},
    );
  }

  getAttributes() async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: '$resource/${Resources.attribute}',
      ),
      negativeResponse: [],
    );
  }

  getPrices() async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: '$resource/${Resources.pricing}',
      ),
      negativeResponse: [],
    );
  }

  //  {
  //   "code": "string",
  //   "description": "string",
  //   "category": "string",
  //   "baseUnitOfMeasure": "string",
  //   "price": 0,
  //   "pricingType": "string"
  // }
  edit({
    String? category,
    String? description,
    String? code,
    String? price,
    String? baseUnitOfMeasure,
    String? pricingType,
  }) async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPut,
      resource: resource,
      body: {
        JsonPayloads.code: code,
        JsonPayloads.description: description,
        JsonPayloads.category: category,
        JsonPayloads.price: price,
        JsonPayloads.pricingType: pricingType,
        JsonPayloads.baseUnitOfMeasure: baseUnitOfMeasure,
      },
    );
  }

  editAttribute({
    required String attribute,
    String? value,
    String? validFrom,
    String? validTo,
  }) async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPut,
      resource: '$resource/${Resources.attribute}',
      queryParameters: {
        QueryParameters.attribute: attribute,
      },
      body: {
        JsonPayloads.value: value,
        JsonPayloads.validFrom: validFrom,
        JsonPayloads.validTo: validTo,
      },
    );
  }

  // TODO: Revise this method
  editPricing({
    required priceType,
    required priceTypeDescription,
    required value,
    required validFrom,
    required validTo,
  }) async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPut,
      resource: '$resource/${Resources.pricing}',
      body: {
        JsonPayloads.priceType: priceType,
        JsonPayloads.priceTypeDescription: priceTypeDescription,
        JsonPayloads.value: value,
        JsonPayloads.validFrom: validFrom,
        JsonPayloads.validTo: validTo,
      },
    );
  }

  addAttribute({
    required String attribute,
    required String value,
    required String product,
    required String validFrom,
    required String validTo,
  }) async {
    {
      return await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPost,
        resource: '$resource/${Resources.attribute}',
        body: {
          JsonPayloads.product: product,
          JsonPayloads.attribute: attribute,
          JsonPayloads.value: value,
          JsonPayloads.validFrom: validFrom,
          JsonPayloads.validTo: validTo,
        },
      );
    }
  }

  // TODO: Revise this method
  addPricing({
    required priceType,
    required String value,
    required String product,
    // required priceTypeDescription,
    required String validFrom,
    required String validTo,
  }) async {
    {
      return await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPost,
        resource: '$resource/${Resources.pricing}',
        body: {
          JsonPayloads.pricing: priceType,
          JsonPayloads.product: product,
          JsonPayloads.value: value,
          // JsonPayloads.priceTypeDescription: priceTypeDescription,
          JsonPayloads.validFrom: validFrom,
          JsonPayloads.validTo: validTo,
        },
      );
    }
  }

  //  {
  //   "code": "string",
  //   "description": "string",
  //   "category": "string",
  //   "baseUnitOfMeasure": "string",
  //   "price": 0,
  //   "pricingType": "string"
  // }
  static create({
    String? code,
    required String description,
    required String category,
    required String type,
    required String measure,
    required String sellingPrice,
    required String pricingType,
  }) async {
    {
      return await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPost,
        resource: Resources.product,
        body: {
          JsonPayloads.code: code,
          JsonPayloads.description: description.trim(),
          JsonPayloads.type: type,
          JsonPayloads.category: category,
          JsonPayloads.baseUnitOfMeasure: measure,
          JsonPayloads.sellingPrice: sellingPrice,
          JsonPayloads.pricingType: pricingType,
          JsonPayloads.autoGenerateCode: 'X',
        },
      );
    }
  }

  delete() async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodDelete,
      resource: resource,
    );
  }

  deleteAttribute(attribute) async {
    return await NetworkRequests().securedMawaAPI(NetworkRequests.methodDelete,
        resource: '$resource/${Resources.attribute}',
        queryParameters: {QueryParameters.attribute: attribute,},);
  }

  deletePricing(String id) async {
    return await NetworkRequests().securedMawaAPI(NetworkRequests.methodDelete,
        resource: '$resource/${Resources.pricing}',
        queryParameters: {QueryParameters.pricing: id,},);
  }
}
