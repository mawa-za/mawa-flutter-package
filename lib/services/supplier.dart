part of 'package:mawa_package/mawa_package.dart';

class Supplier {


  final String supplierID;
  static dynamic supplier;

  Supplier(this.supplierID);



  static getAll() async {
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: Resources.supplier,
        ),
        negativeResponse: []);
  }
  static getSpecific(supplierID) async {
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: '${Resources.supplier}/$supplierID',
        ),
        negativeResponse: {});
  }
  //GET PARTNER CONTACT

  getPartnerAttribute(path) async {
    //String path='contact';
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: '${Resources.partner}/$supplierID/$path',
        ),
        negativeResponse: {});
  }
  static addContactOnCreate({String ? partnerId, String ? contactType, String ? value  }) async{
    await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPost,
        resource: '${Resources.partner}/$partnerId/contact',
        body: {
          JsonPayloads.type : contactType,
          JsonPayloads.value : value,
        }
    ));
  }
  //ADD PARTNER ATTRIBUTE
  addPartnerAttribute({

    required String pathType,
    required String attributeValue,
    required String attributeType,
  }) async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPost,
      resource: '${Resources.partner}/$supplierID/$pathType',
      body: {

        JsonPayloads.idType : attributeType,
        JsonPayloads.idNumber : attributeValue,

      },
    );
  }
  static getPartnerByRole({required String partnerRole}) async{
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: Resources.partner,
          queryParameters: {
            QueryParameters.role : partnerRole
          },
        ),
        negativeResponse: []);
  }
//http://dev.api.app.mawa.co.za/partner?role=supplier
}