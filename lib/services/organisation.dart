part of 'package:mawa_package/mawa_package.dart';

class Organisation {

  final String organisationID;
  static dynamic organisation,organisationid;

  Organisation(this.organisationID);


  static getAll() async {
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: Resources.organization,
        ),
        negativeResponse: []);
  }
  getSpecific() async {
    organisation = await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: '${Resources.organization}/$organisationID'),
      negativeResponse: {},
    );
    return organisation;
  }
  getSpecificByPartner() async {
    organisation = await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: '${Resources.partner}/$organisationID'),
      negativeResponse: {},
    );
    return organisation;
  }
  static quickCreate({

    required String partnerType,
    required String organisationName,

  }) async {
    DateTime dateCreated=DateTime.now();
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPost,
      resource: Resources.partner,
      body: {

        JsonPayloads.type : partnerType,
        JsonPayloads.name1 : organisationName,
        JsonPayloads.birthDate : dateCreated,
      },
    );
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

  static editOrganisation(
      {
        required dynamic body,
        required String? partner

      }) async {

    dynamic response= await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPut,
        resource:'${Resources.partner}/$partner',
        body :body
    );
    return response;
  }
  //ADD PARTNER ATTRIBUTE
  addPartnerAttribute({

    required String pathType,
    required String attributeValue,
    required String attributeType,
  }) async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPost,
      resource: '${Resources.partner}/$organisationID/$pathType',
      body: {

        JsonPayloads.type : attributeType,
        JsonPayloads.value : attributeValue,

      },
    );
  }
 getSpecificPartner() async {
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: '${Resources.partner}/$organisationID',
        ),
        negativeResponse: {});

  }
  addPartnerAttribute_({

    required String pathType,
    required String attributeValue,
    required String attributeType,
  }) async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPost,
      resource: '${Resources.persons}/$organisationID/$pathType',
      body: {

        JsonPayloads.idType : attributeType,
        JsonPayloads.idNumber : attributeValue,

      },
    );
  }
  static addOrgContact({

    required String pathType,
    required String attributeValue,
    required String attributeType,
    required String organisationID,
  }) async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPost,
      resource: '${Resources.partner}/$organisationID/$pathType',
      body: {

        JsonPayloads.type : attributeType,
        JsonPayloads.value : attributeValue,

      },
    );
  }

  static addOrgIdentity_({

    required String pathType,
    required String attributeValue,
    required String attributeType,
    required String organisationID,
  }) async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPost,
      resource: '${Resources.persons}/$organisationID/$pathType',
      body: {

        JsonPayloads.idType : attributeType,
        JsonPayloads.idNumber : attributeValue,

      },
    );
  }
  //GET PARTNER CONTACT

  getPartnerAttribute(path) async {
    //String path='contact';
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: '${Resources.partner}/$organisationID/$path',
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


}