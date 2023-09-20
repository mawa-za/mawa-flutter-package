part of 'package:mawa_package/mawa_package.dart';

class Product {
  Product(this.id) {
    resource = '${Resources.product}/$id';
  }
  late String resource;
  final String id;

  static getFromCategory(category) async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: Resources.product,
        queryParameters: {
          'category': category,
        },
      ),
    ); //
  }

  static generateProductsMap(String category, String key) async {
    dynamic list = await Product.getFromCategory(category);
    Map<String, String> data = {};
    if (list != null) {
      switch (key) {
        case JsonResponses.id:
          {
            for (int i = 0; i < list.length; i++) {
              data['${list[i][JsonResponses.id]}'] =
                  list[i][JsonResponses.description];
            }
          }
          break;
        case JsonResponses.description:
          {
            for (int i = 0; i < list.length; i++) {
              data['${list[i][JsonResponses.description]}'] =
                  list[i][JsonResponses.id];
            }
          }
          break;
      }
    }
    return data;
  }

  dynamic getProductInfo(category) async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: Resources.products,
        queryParameters: {
          QueryParameters.category: category,
        },
      ),
    );
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

  // static mapAll(String key) async {
  //   dynamic list = await getAll();
  //   Map<String, Map<String, dynamic>> data = {};
  //   if (list != null) {
  //     switch (key) {
  //       case JsonResponses.id:
  //         {
  //           for (int i = 0; i < list.length; i++) {
  //             data['${list[i][JsonResponses.id]}'] =
  //             list[i];
  //           }
  //         }
  //         break;
  //       case JsonResponses.description:
  //         {
  //           for (int i = 0; i < list.length; i++) {
  //             data['${list[i][JsonResponses.description]}'] =
  //             list[i];
  //           }
  //         }
  //         break;
  //     }
  //   }
  //   return data;
  // }

  get() async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: resource,
      ),
      negativeResponse: {},
    );
  }

  getProductAttributes() async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: '$resource/${Resources.attributes}',
      ),
      negativeResponse: {},
    );
  }

  getProductPricing() async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: '$resource/${Resources.pricing}',
      ),
      negativeResponse: {},
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

  editProductAttributes({
    required attribute,
    required value,
    required validFrom,
    required validTo,
  }) async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPut,
      resource: '$resource/${Resources.attributes}',
      body: {
        JsonPayloads.attribute: attribute,
        JsonPayloads.value: value,
        JsonPayloads.validFrom: validFrom,
        JsonPayloads.validTo: validTo,
      },
    );
  }

  editProductPricing({
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
    required attribute,
    required String value,
    required dynamic validFrom,
  }) async {
    {
      return await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPost,
        resource: '$resource/${Resources.attributes}',
        body: {
          JsonPayloads.attribute: attribute,
          JsonPayloads.value: value,
          JsonPayloads.validFrom: validFrom,
        },
      );
    }
  }

  addPricing({
    required priceType,
    required priceTypeDescription,
    required String value,
    required dynamic validFrom,
  }) async {
    {
      return await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPost,
        resource: '$resource/${Resources.pricing}',
        body: {
          JsonPayloads.priceType: priceType,
          JsonPayloads.priceTypeDescription: priceTypeDescription,
          JsonPayloads.value: value,
          JsonPayloads.validFrom: validFrom,
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
  static add({
    String? code,
    required String productDescription,
    required String productCategory,
    required String measure,
    required String sellingPrice,
  }) async {
    {
      return await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPost,
        resource: Resources.product,
        body: {
          JsonPayloads.code: code,
          JsonPayloads.description: Strings.description(productDescription.trim()),
          JsonPayloads.category: productCategory,
          JsonPayloads.baseUnitOfMeasure: measure,
          JsonPayloads.sellingPrice: sellingPrice,
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
}
