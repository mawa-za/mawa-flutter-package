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
        required String item,
      required String code,
      required String description,
        String? ean,
        String? uom,
        double quantity =0,
        double unitPrice =0,
        double lineTotal =0}) async {
    Map payload = {
      JsonPayloads.itemId: item,
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

  itemEdit(
      {required String transaction,
        required String item,
        required String productId,
        required String code,
        required String description,
        String? ean,
        String? uom,
        double quantity =0,
        double unitPrice =0,
        double lineTotal =0}) async {
    Map payload = {
      JsonPayloads.itemId: item,
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
        .securedMawaAPI(NetworkRequests.methodPut,
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
