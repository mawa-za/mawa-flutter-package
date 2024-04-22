part of 'package:mawa_package/mawa_package.dart';

class Product {
  Product(this.id) {
    resource = '${Resources.product}/$id';
  }
  late String resource;
  final String id;

  static search({String? category, String? code, String? type}) async {
    Map<String, String> query = {};
    if (category != null) {
      query[JsonPayloads.category] = category;
    }
    if (type != null) {
      query[JsonPayloads.type] = type;
    }
    if (code != null) {
      query[JsonPayloads.code] = code;
    }
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: Resources.product,
        queryParameters: query,
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

  getCategories() async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: '$resource/${Resources.category}',
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

  addPricing({
    required priceType,
    required String value,
    required String product,
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
          JsonPayloads.validFrom: validFrom,
          JsonPayloads.validTo: validTo,
        },
      );
    }
  }

  addCategory({
    required List<String> categories,
  }) async {
    {
      return await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPost,
        resource: '$resource/${Resources.category}',
        body:  categories,
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
          JsonPayloads.baseUnitOfMeasure: measure,
          JsonPayloads.price: sellingPrice,
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
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodDelete,
      resource: '$resource/${Resources.attribute}',
      queryParameters: {
        QueryParameters.attribute: attribute,
      },
    );
  }

  deletePricing(String id) async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodDelete,
      resource: '$resource/${Resources.pricing}',
      queryParameters: {
        QueryParameters.pricing: id,
      },
    );
  }

  deleteCategory(String category) async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodDelete,
      resource: '$resource/${Resources.category}',
      queryParameters: {
        QueryParameters.category : category,
      },
    );
  }
}
