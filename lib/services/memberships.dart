import 'package:mawa_package/services/keys.dart';
import 'package:mawa_package/services/network_requests.dart';
import 'package:mawa_package/services/persons.dart';

class Memberships {
  static Map<dynamic, dynamic> policy = {};
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
  }

  membershipGet({String? policyId}) async {
    policy.clear();
     dynamic response = await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
        resource: '${Resources.policies}/$policyId');
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

}