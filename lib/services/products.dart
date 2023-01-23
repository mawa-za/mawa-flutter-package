part of 'package:mawa_package/mawa_package.dart';

class Products {
  static String? productId;
  late String policyType;
  late String policyDescription;
  late String payout;
  final String _directory = 'product/?category=';
  List/*<Map>*/ products = [];
  List allProducts = [];
  List attributes = [];
  List pricing = [];
  dynamic edit = '';
  // Map product = {};
  static Map<String, String> productsMap = {};
  static dynamic personsPolicies;
  static dynamic personsTombstones;
  static dynamic product;

  Map<String, dynamic> policyList = {};

  productsList(category) async {
    products = await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: Resources.products,
        queryParameters: {'category': category})); //
    return products;
  }

  generatePoliciesMap(String key) async {
    dynamic list = await Products().productsList(Tools.productCategoryFuneralPolicy);
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
    await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet, resource: Resources.products,queryParameters: {QueryParameters.category:category}));
    int statusCode = response.statusCode;
    var data = response.body;

    List list = jsonDecode(data);
    return list;
  }

  getAllProducts() async {
    allProducts = await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: Resources.products,
        ), negativeResponse: {});
    return allProducts;
  }

  getSpecificProduct({required String id})async {
    product = await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: Resources.products +'/'+ id,
        ), negativeResponse: {});
    return product;
  }

  getProductAttributes(String id) async {
    attributes = await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: '${Resources.products}/$id/${Resources.attributes}',
        ), negativeResponse: {});
    return attributes;
  }

  getProductPricing(String id) async {
    pricing = await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: '${Resources.products}/$id/${Resources.pricing}',
        ), negativeResponse: {});
    return pricing;
  }

  editProductAttributes({required String id,required attribute,required value,required validFrom,  required validTo}) async{
    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPut,
        resource: '${Resources.products}/$id/${Resources.attributes}',
        body:
        {
          JsonPayloads.attribute: attribute,
          JsonPayloads.value: value,
          JsonPayloads.validFrom: validFrom,
          JsonPayloads.validTo: validTo,
        });

    return await response;
  }

  editProductPricing({required String id,required priceType,required priceTypeDescription,required value,required validFrom,  required validTo}) async{
    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPut,
        resource: '${Resources.products}/$id/${Resources.pricing}',
        body:
        {
          JsonPayloads.priceType: priceType,
          JsonPayloads.priceTypeDescription: priceTypeDescription,
          JsonPayloads.value: value,
          JsonPayloads.validFrom: validFrom,
          JsonPayloads.validTo: validTo,
        });

    return await response;
  }

  AddProductAttribute(
      {required String id,
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

  AddProductPricing(
      {required String id,
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
}
