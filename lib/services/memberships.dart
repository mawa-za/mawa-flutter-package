part of mawa;

class Memberships {
  static Map<dynamic, dynamic> policy = {};
  static List<dynamic> allPolicies = [];
  static List personsPolicies = [];

  static String? policyId;

  membershipsSearch({String? partnerRole, String? idNumber}) async {
    List policies = await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
        resource: Resources.policies,
        queryParameters: {
          'idnumber': idNumber ?? Persons.person[JsonResponses.personIdNumber] ?? Persons.personIdNumber,
          'partnerRole': partnerRole
        }) ?? [];
    if(/*policies.runtimeType == List &&*/ policies.isNotEmpty){
      personsPolicies = policies;
    }
    else {
      personsPolicies = [];
    }
  }

  membershipGet(policyId) async {
    policy.clear();
     dynamic response = await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
        resource: '${Resources.policies}/$policyId');
    print('try'+response.toString());
    // policy == null ? policy = {} : response != null ? response.isNotEmpty ? policy = response : policy = {}  : policy = {} ;
    if( response != null && response.isNotEmpty){
      if(response.runtimeType == allPolicies.runtimeType) {
        allPolicies = response;
      }
      else{
        policy = response;
      }
    }
    else {
      policy.clear();
      allPolicies.clear();
    }
    policy == null ? policyId = policy[JsonResponses.policyId] : policyId = '';
    print('\n2try'+policy.toString());
  }
}