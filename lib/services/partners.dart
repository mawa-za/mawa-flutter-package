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
  addIdentity(
      {required String? path,
        required dynamic idType,
        required String? idNumber}) async {
    return await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPost,
        resource: '${Resources.persons}/$partnerId/$path',
        body: {
          JsonPayloads.idType: idType,
          JsonPayloads.personIdNumber: idNumber,
        });
  }
    addContact(
        {required String? path,
          required String? contactType,
          required dynamic detail}) async {
      dynamic response = await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodPost,
          resource: '${Resources.partner}/$partnerId/$path',
          body: {
            JsonPayloads.type: contactType,
            JsonPayloads.cellNumber: detail,
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