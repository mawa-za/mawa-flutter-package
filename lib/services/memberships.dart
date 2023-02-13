part of 'package:mawa_package/mawa_package.dart';

class Memberships {
  static dynamic policy;
  static List<dynamic> allPolicies = [];
  static List personsPolicies = [];

  static String? policyId;

  membershipsSearch({String? partnerRole, String? idNumber}) async {
    personsPolicies.clear();
    dynamic response = await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
        resource: Resources.policies,
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

  membershipGet({String? policyId}) async {
    // policy.clear();
     dynamic response = await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
        resource: '${Resources.policies}/${policyId ?? ''}');
      dynamic body =  await NetworkRequests.decodeJson(response);
      // if(policyId != null)
      try{
        policy =  body ?? {};
        policy.isNotEmpty ? policyId = policy[JsonResponses.id] : policyId = '';
        Persons.person = Memberships.policy[JsonResponses.policyCustomerDetails];
        return policy;
      }
      // else
        catch(e){
        print('All poli');
        allPolicies = body ?? [];
        return allPolicies;
    }
  }

  createNewMembership(details) async {
    return await NetworkRequests().securedMawaAPI(NetworkRequests.methodPost,
        resource: '${Resources.policies} ', body: details);
  }

  //METHODS FOR THE NEW BACKEND

  getMembership(String id) async {
    return await NetworkRequests.decodeJson( await NetworkRequests()
        .securedMawaAPI(NetworkRequests.methodGet, resource: '${Resources.membership}/$id'));
  }

}