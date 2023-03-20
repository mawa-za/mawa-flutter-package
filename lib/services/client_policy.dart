part of 'package:mawa_package/mawa_package.dart';

class Policies {

  getPolicyDetails(policyID) async {
  return await NetworkRequests.decodeJson( await NetworkRequests()
        .securedMawaAPI(NetworkRequests.methodGet, resource: '${Resources.policies}/$policyID'));
  }

  createNewPolicy(details) async {
    return await NetworkRequests().securedMawaAPI(NetworkRequests.methodPost, resource: Resources.policies, body: details);
  }

  searchClientPolicies(String idNumber) async {
    return await NetworkRequests.decodeJson( await NetworkRequests()
        .securedMawaAPI(NetworkRequests.methodGet, resource: '${Resources.policies}/$idNumber'));
  }

  getDependents(String policyId) async {
    return await NetworkRequests.decodeJson( await NetworkRequests()
        .securedMawaAPI(NetworkRequests.methodGet, resource: '${Resources.policies}/$policyId/${Resources.dependents}'));
  }

}

// part of mawa;
//
// class Policies {
//
//   getPolicyDetails(policyID) async {
//   return await NetworkRequests()
//         .securedMawaAPI(NetworkRequests.methodGet, resource: '${Resources.policies}/$policyID');
//   }
//
//   createNewPolicy(details) async {
//     return await NetworkRequests()
//         .securedMawaAPI(NetworkRequests.methodPost, resource: '${Resources.policies}', body: details);
//   }
//
//   searchClientPolicies(String idNumber) async {
//     return await NetworkRequests()
//         .securedMawaAPI(NetworkRequests.methodGet, resource: '${Resources.policies}/$idNumber');
//   }
// }
