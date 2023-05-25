part of 'package:mawa_package/mawa_package.dart';

class Partners {
  static List partner  =[];
  late String partnerId;
  Partners(this.partnerId);
  static getPartnerByRole(
      {required String partnerRole}) async {
    partner = await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
            resource: '${Resources.partner}/$partnerRole/${Resources.role}'),
            negativeResponse: []);

        return partner;
  }
  static createPartner(
      {
        required dynamic body

      }) async {
    dynamic response= await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPost,
        resource: Resources.partner,
        body :body
    );
    return response;
  }

  Future assignPersonRole({required String partnerRole}) async {
    await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPost,
        resource: '${Resources.partner}/$partnerId/${Resources.assign}',
        queryParameters: {QueryParameters.role: partnerRole}));
  }

  static getSpecificPartner(String partnerId) async {
   return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: '${Resources.partner}/$partnerId',
        ),
        negativeResponse: {});

  }
  getPartnerDetails({required String path}) async {
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: '${Resources.partner}/$partnerId/$path',
        ),
        negativeResponse: {});

  }
  getSpecificPartnerAddress({String ? path, String ? type}) async{
    await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPost,
        resource: '${Resources.partner}/$path',
        queryParameters: {QueryParameters.type:type}));
  }

  addIdentity(
      {  String? path,
        String ? idType,
        String? idNumber}) async {
    return await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPost,
        resource: '${Resources.persons}/$partnerId/$path',
        body: {
          JsonPayloads.idType: idType,
          JsonPayloads.personIdNumber: idNumber,
        });
  }
    addContact(
        {  String ? path,
          String ? contactType,
           dynamic detail}) async {
      dynamic response = await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodPost,
          resource: '${Resources.partner}/$partnerId/$path',
          body: {
            JsonPayloads.type: contactType,
            JsonPayloads.value: detail,
          });
      return response;
    }
  addAdress(
      {  String? path,
        String? addressType,
        String? houseno,
        String? streetName,
        dynamic suburb,
        dynamic city,
        String? postalCode}) async {
    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPost,
        resource: '${Resources.partner}/$partnerId/$path',
        body: {
          JsonPayloads.type: addressType,
          JsonPayloads.addressline1: houseno,
          JsonPayloads.addressline2: streetName,
          JsonPayloads.addressline3: suburb,
          JsonPayloads.addressline4: city,
          JsonPayloads.postalCode: postalCode,
        });
    return response;
  }
   deleteAddress({String ? path, dynamic addressId, String ? type }) async{
     await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(
         NetworkRequests.methodDelete,
         resource: '${Resources.partner}/$partnerId/$path',
         queryParameters: {
           QueryParameters.addressId: addressId,
           QueryParameters.type: type
         }
     ));
   }
  deleteContact({String ? path, String ? type }) async{
    await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodDelete,
        resource: '${Resources.partner}/$partnerId/$path',
        queryParameters: {
          QueryParameters.type: type
        }
    ));
  }
  deleteRole({String ? path, String ? role }) async{
    await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodDelete,
        resource: '${Resources.partner}/$partnerId/$path',
        queryParameters: {
          QueryParameters.role: role
        }
    ));
  }

  static deleteIdentity({String ? path, String ? idType, String ? idNumber  }) async{
    await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodDelete,
        resource: '${Resources.partner}/$path',
        queryParameters: {
          QueryParameters.idType : idType,
          QueryParameters.idNumber : idNumber,
        }
    ));
  }
   assignPartnerRole({required String path, dynamic body}) async {
     dynamic response = await NetworkRequests().securedMawaAPI(
         NetworkRequests.methodPost,
         resource: '${Resources.partner}/$partnerId/$path',
         body: body);
     return response;
   }

  get() async {
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: '${Resources.partner}/$partnerId',
        ),
        negativeResponse: {});
  }

  static getAll() async {
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: Resources.partner,
        ),
        negativeResponse: []);
  }



}