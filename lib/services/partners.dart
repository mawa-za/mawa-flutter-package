part of 'package:mawa_package/mawa_package.dart';

class Partners {
  static dynamic partner;

  static getPartnerByRole(
      {required String partnerRole}) async {
    partner.clear();
    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: '${Resources.partners}/$partnerRole/${Resources.role}',
        );

    partner = await NetworkRequests.decodeJson(response, negativeResponse: {});
    return partner;
  }

}