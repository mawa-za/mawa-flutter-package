part of 'package:mawa_package/mawa_package.dart';

class Organisation {

  final String organisationID;
  static dynamic organisation;

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
  static quickCreate({

    required String partnerType,
    required String organisationName,
  }) async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPost,
      resource: Resources.prospect,
      body: {

        JsonPayloads.partnerType : partnerType,
        JsonPayloads.surname : organisationName,
        JsonPayloads.organizationName : organisationName,
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


}