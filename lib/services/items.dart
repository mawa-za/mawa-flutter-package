part of 'package:mawa_package/mawa_package.dart';

class Items {
  Items({required this.path, required this.id});

  final String id;
  final String path;
  // POST /{id}/items
  //{
  //   "transaction": "string",
  //   "productId": "string",
  //   "code": "string",
  //   "description": "string",
  //   "ean": "string",
  //   "uom": "string",
  //   "quantity": 0,
  //   "unitPrice": 0,
  //   "lineTotal": 0
  // }
  itemCreate(
      {required String transaction,
      required String productId,
      required String code,
      required String description,
      required String ean,
      required String uom,
      required String quantity,
      required String unitPrice,
      required String lineTotal}) async {
    Map payload = {
      JsonPayloads.transaction: transaction,
      JsonPayloads.productId: productId,
      JsonPayloads.code: code,
      JsonPayloads.description: description,
      JsonPayloads.ean: ean,
      JsonPayloads.uom: uom,
      JsonPayloads.quantity: quantity,
      JsonPayloads.unitPrice: unitPrice,
      JsonPayloads.lineTotal: lineTotal
    };
    return await NetworkRequests()
        .securedMawaAPI(NetworkRequests.methodPost,
        resource: '$path/$id/${Resources.items}',
      body: payload,
    );
  }

  // GET /{id}/items
  getItems() async {
    return await NetworkRequests.decodeJson(
        await NetworkRequests()
        .securedMawaAPI(NetworkRequests.methodGet,
            resource: '$path/$id/${Resources.items}'),
      negativeResponse: [],
    );
  }
}
