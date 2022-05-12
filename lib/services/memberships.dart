import 'package:mawa/services/keys.dart';
import 'package:mawa/services/network_requests.dart';
import 'package:mawa/services/persons.dart';

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

  membershipGet(policyId) async {
    policy.clear();
     dynamic response = await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
        resource: '${Resources.policies}/$policyId');
    // policy == null ? policy = {} : response != null ? response.isNotEmpty ? policy = response : policy = {}  : policy = {} ;
    if( response.statusCode == 200){
      dynamic body =  await NetworkRequests.decodeJson(response);
      // if(response.runtimeType == allPolicies.runtimeType)
      try
      {
        allPolicies = body ?? [];
      }
      // else
      catch(e)
          {
        policy =  body ?? {};
      }
    }
    else {
      policy.clear();
      allPolicies.clear();
    }
    policy == null ? policyId = policy[JsonResponses.id] : policyId = '';
  }
}