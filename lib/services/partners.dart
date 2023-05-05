part of 'package:mawa_package/mawa_package.dart';

class Partners {
  static dynamic partner;
  late String partnerId;
  Partners(this.partnerId);
  static getPartnerByRole(
      {required String partnerRole}) async {
    partner.clear();
    dynamic response = await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodGet,
      resource: '${Resources.partner}/$partnerRole/${Resources.role}',
    );

    partner = await NetworkRequests.decodeJson(response, negativeResponse: {});
    return partner;
  }

  static createPartner(
      {
        required dynamic body
        // dynamic type,
        // String? name1,
        // String? name2,
        // String? name3,
        // String? name4,
        // dynamic idType,
        // dynamic idNumber,
        // dynamic gender,
        // dynamic title,
        // dynamic maritalStatus,
        // dynamic birthdate,
      }) async {
    dynamic response= await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPost,
        resource: Resources.partner,
        body :body
      // body: {
      //   JsonPayloads.type: type,
      //   JsonPayloads.name1: name1,
      //   JsonPayloads.name2: name2,
      //   JsonPayloads.name3: name3,
      //   JsonPayloads.name4: name4,
      //   JsonPayloads.idType : idType,
      //   JsonResponses.idNumber:idNumber,
      //   JsonPayloads.gender: gender,
      //   JsonPayloads.title: title,
      //   JsonPayloads.maritalStatus: maritalStatus,
      //   JsonPayloads.birthDate: birthdate
      // }
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


}