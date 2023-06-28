part of 'package:mawa_package/mawa_package.dart';

class Prospect {

  static dynamic prospect;
  final String prospectID;

  Prospect(this.prospectID);

  static getAll() async {
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: Resources.prospects,
        ),
        negativeResponse: []);
  }

  static getAllByPartner() async {
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: Resources.partner,
        ),
        negativeResponse: []);
  }
  //  getSpecific() async {
  //   return await NetworkRequests.decodeJson(
  //       await NetworkRequests().securedMawaAPI(
  //         NetworkRequests.methodGet,
  //         resource: '${Resources.prospects}/$prospectID',
  //       ),
  //       negativeResponse: {});
  // }
  //ADD PARTNER ATTRIBUTE
  addPartnerAttribute({

    required String pathType,
    required String attributeValue,
    required String attributeType,
  }) async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPost,
      resource: '${Resources.partner}/$prospectID/$pathType',
      body: {

        JsonPayloads.type : attributeType,
        JsonPayloads.value : attributeValue,

      },
    );
  }
  //GET PARTNER CONTACT
  getPartnerAttribute(path) async {
    //String path='contact';
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: '${Resources.partner}/$prospectID/$path',
        ),
        negativeResponse: {});
  }
  getSpecific() async {
    prospect = await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: '${Resources.partner}/$prospectID'),
      negativeResponse: {},
    );
    return prospect;
  }



  static createProspect({
    required String fName,
    required String lName,
    required String midName,
    required String partnerType,
    required String organisationName,
  }) async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPost,
      resource: Resources.prospect,
      body: {
        JsonPayloads.firstName : fName,
        JsonPayloads.lastName : lName,
        JsonPayloads.middleName : midName,
        JsonPayloads.partnerType : partnerType,
        JsonPayloads.organizationName : organisationName,
      },
    );
  }

}