part of mawa;

class Products {
  late String policyType;
  late String policyDescription;
  late String payout;
  final String _directory = 'product/?category=';
  List/*<Map>*/ products = [];
  static Map<String, String> productsMap = {};
  static dynamic personsPolicies;
  static dynamic personsTombstones;
  static dynamic product;

  Map<String, dynamic> policyList = {};

  productsList(context, category) async {
    products =  NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: Resources.products,
        queryParameters: {'category': category})); //
    print('products $products');
    return products;
  }

  generatePoliciesMap(String key) async {
    dynamic list =  NetworkRequests.decodeJson(await (Products().productsList(
        Tools.context, Tools.productCategoryFuneralPolicy)));
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
    // print('meva \n${Products.productsMap}');
  }

  dynamic getProductInfo(category) async {
    String url = NetworkRequests().endpointURL + _directory + category;
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": "Bearer ${NetworkRequests.token}"
    };

    final http.Response response =
        // await http.get(Uri.http(url, ''), headers: headers);
    NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet, resource: Resources.products,queryParameters: {QueryParameters.category:category}));
    int statusCode = response.statusCode;
    var data = response.body;

    List list = jsonDecode(data);
    print(statusCode);
    print(data);
    print(list.length);
    print('sa ${policyList.keys}');
    return list;
  }
}
