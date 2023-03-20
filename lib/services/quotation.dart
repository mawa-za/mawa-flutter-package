part of 'package:mawa_package/mawa_package.dart';

class Quotation{
  Quotation({required this.id});

  final String id;

  static Map<String, String> items(

    {
      required String transaction,
  required String productId,
  required String code,
  required String description,
  required String ean,
  required String uom,
  required String quantity,
  required String unitPrice,
      required String lineTotal
    }
      ){
     return
    {
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
  }

// POST /mawa-api/resources/quotation
//  {
//   "customerId": "string",
//   "deliveryDate": "2023-02-23T06:36:27.343Z",
//   "expiryDate": "2023-02-23T06:36:27.343Z",
//   "items": [
//     {
//       "transaction": "string",
//       "productId": "string",
//       "code": "string",
//       "description": "string",
//       "ean": "string",
//       "uom": "string",
//       "quantity": 0,
//       "unitPrice": 0,
//       "lineTotal": 0
//     }
//   ]
// }
  createQuote({
    required String customerID,
    required String deliveryDate,
    required List items,
    required String expiryDate,
})async{
    return await NetworkRequests().securedMawaAPI(NetworkRequests.methodPost,
        resource: Resources.quotation,
        body: {
      JsonPayloads.customerId: customerID,
      JsonPayloads.deliveryDate: deliveryDate,
      JsonPayloads.expiryDate: expiryDate,
      JsonPayloads.items: items,
    },
    );

  }

  // PUT /mawa-api/resources/quotation/{id}
  // {
  //   "id": "string",
  //   "number": "string",
  //   "type": "string",
  //   "subType": "string",
  //   "description": "string",
  //   "subDescription": "string",
  //   "status": "string",
  //   "statusReason": "string",
  //   "location": "string",
  //   "subStatus": "string",
  //   "validFrom": "string",
  //   "validTo": "string",
  //   "createdBy": "string",
  //   "changedBy": "string"
  // }
  editQuote()async{

    return await NetworkRequests().securedMawaAPI(NetworkRequests.methodPut,
      resource: '${Resources.quotation}/$id',
      body: {

      },
    );
  }

  getQuote()async{
    return await NetworkRequests.decodeJson( await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
      resource: id == '' ? Resources.quotation : '${Resources.quotation}/$id',
    ),
      negativeResponse: {},
    );
  }

  getQuoteDetail(String detail)async{
    return await NetworkRequests.decodeJson( await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodGet,
      resource: '${Resources.quotation}/$id/$detail',
    ),
      negativeResponse: {},
    );
  }

  deleteQuote()async{
    return  await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodDelete,
      resource: '${Resources.quotation}/${id ?? ''}',
    );
  }

}