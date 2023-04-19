part of 'package:mawa_package/mawa_package.dart';

class Products {
  Products(this.id);
  final String id;
  static late String productId = '';
  late String policyType;
  late String policyDescription;
  late String payout;
  final String _directory = 'product/?category=';
  List/*<Map>*/ products = [];
  static dynamic allProducts;
  List attributes = [];
  List pricing = [];
  dynamic edit = '';
  Map productMap = {};
  static Map<String, String> productsMap = {};
  static dynamic personsPolicies;
  static dynamic personsTombstones;
  static dynamic product;

  Map<String, dynamic> policyList = {};

  static getFromCategory(category) async {
    return await NetworkRequests.decodeJson(await NetworkRequests()
        .securedMawaAPI(NetworkRequests.methodGet,
            resource: Resources.product,
            queryParameters: {'category': category})); //
  }

  generatePoliciesMap(String key) async {
    dynamic list =
        await Products.getFromCategory(Tools.productCategoryFuneralPolicy);
    Map<String, String> data = {};
    if (list != null) {
      switch (key) {
        case JsonResponses.id:
          {
            for (int i = 0; i < list.length; i++) {
              data['${list[i][JsonResponses.id]}'] =
                  list[i][JsonResponses.productDescription];
            }
          }
          break;
        case JsonResponses.productDescription:
          {
            for (int i = 0; i < list.length; i++) {
              data['${list[i][JsonResponses.productDescription]}'] =
                  list[i][JsonResponses.id];
            }
          }
          break;
      }
    }
    Products.productsMap = data;
    return productsMap;
  }

  dynamic getProductInfo(category) async {
    String url = NetworkRequests().endpointURL + _directory + category;
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": "Bearer ${NetworkRequests.token}"
    };

    final http.Response response =
        // await http.get(Uri.http(url, ''), headers: headers);
        await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(
            NetworkRequests.methodGet,
            resource: Resources.products,
            queryParameters: {QueryParameters.category: category}));
    int statusCode = response.statusCode;
    var data = response.body;

    List list = jsonDecode(data);
    return list;
  }

  static getlAll() async {
    allProducts = await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: Resources.product,
        ),
        negativeResponse: []);
    return allProducts;
  }

  getSpecificProduct() async {
    product = await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: '${Resources.product}/$id',
        ),
        negativeResponse: {});
    return product;
  }

  getProductAttributes() async {
    attributes = await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: '${Resources.products}/$id/${Resources.attributes}',
        ),
        negativeResponse: {});
    return attributes;
  }

  getProductPricing() async {
    pricing = await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: '${Resources.products}/$id/${Resources.pricing}',
        ),
        negativeResponse: {});
    return pricing;
  }

  editProduct({
    required category,
    required description,
    required code,
  }) async {
    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPut,
        resource: '${Resources.product}/$id',
        body: {
          JsonPayloads.code: code,
          JsonPayloads.description: description,
          JsonPayloads.category: category,
        });
    return response;
  }

  editProductAttributes({
      required attribute,
      required value,
      required validFrom,
      required validTo}) async {
    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPut,
        resource: '${Resources.products}/$id/${Resources.attributes}',
        body: {
          JsonPayloads.attribute: attribute,
          JsonPayloads.value: value,
          JsonPayloads.validFrom: validFrom,
          JsonPayloads.validTo: validTo,
        });

    return await response;
  }

  editProductPricing({
      required priceType,
      required priceTypeDescription,
      required value,
      required validFrom,
      required validTo}) async {
    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPut,
        resource: '${Resources.products}/$id/${Resources.pricing}',
        body: {
          JsonPayloads.priceType: priceType,
          JsonPayloads.priceTypeDescription: priceTypeDescription,
          JsonPayloads.value: value,
          JsonPayloads.validFrom: validFrom,
          JsonPayloads.validTo: validTo,
        });

    return await response;
  }

  AddProductAttribute({
    required attribute,
    required String value,
    required dynamic validFrom,
  }) async {
    {
      dynamic response = await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodPost,
          resource: '${Resources.products}/$id/${Resources.attributes}',
          body: {
            JsonPayloads.attribute: attribute,
            JsonPayloads.value: value,
            JsonPayloads.validFrom: validFrom,
          });

      return response;
    }
  }

  AddProductPricing({
    required priceType,
    required priceTypeDescription,
    required String value,
    required dynamic validFrom,
  }) async {
    {
      dynamic response = await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodPost,
          resource: '${Resources.products}/$id/${Resources.pricing}',
          body: {
            JsonPayloads.priceType: priceType,
            JsonPayloads.priceTypeDescription: priceTypeDescription,
            JsonPayloads.value: value,
            JsonPayloads.validFrom: validFrom,
          });

      return response;
    }
  }

  static AddProduct({
    required code,
    required productDescription,
    required productCategory,
    required measure,
    required sellingPrice,
  }) async {
    {
      return await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodPost,
          resource: Resources.product,
          body: {
            JsonPayloads.code: code,
            JsonPayloads.description: productDescription,
            JsonPayloads.category: productCategory,
            JsonPayloads.baseUnitOfMeasure: measure,
            JsonPayloads.sellingPrice: sellingPrice,
          });
    }
  }

  deleteProduct() async {
    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodDelete,
        resource: '${Resources.product}/$id');
    return response;
  }
}
