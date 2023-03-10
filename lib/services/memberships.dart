part of 'package:mawa_package/mawa_package.dart';

class Memberships {
  static dynamic membership;
  static List<dynamic> allPolicies = [];
  static List personsPolicies = [];

  final String membershipID;

  Memberships(this.membershipID);

  membershipsSearch({String? partnerRole, String? idNumber}) async {
    personsPolicies.clear();
    dynamic response = await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
        resource: Resources.membership,
        queryParameters: {
          'idnumber': idNumber ?? Persons.person[JsonResponses.personIdNumber] ?? Persons.personIdNumber,
          'partnerRole': partnerRole
        }) ?? [];
    // if(response.statusCode == 200){
      personsPolicies = await NetworkRequests.decodeJson(response, negativeResponse: []);
    // }
    // else {
    //   personsPolicies = [];
    // }
    return personsPolicies;
  }

  getMembership() async {
     membership = await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
        resource: '${Resources.membership}/$membershipID' ), negativeResponse: {});
     return membership;
  }

  static getAllMembership() async {
     membership = await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
        resource: Resources.membership ), negativeResponse: {});
     return membership;
  }

  createNewMembership(details) async {
    return await NetworkRequests().securedMawaAPI(NetworkRequests.methodPost,
        resource: '${Resources.membership} ', body: details);
  }

  getAttribute(String attribute) async {
    return await NetworkRequests.decodeJson(await NetworkRequests()
        .securedMawaAPI(NetworkRequests.methodGet, resource: '${Resources.membership}/$membershipID/$attribute'));
  }

}