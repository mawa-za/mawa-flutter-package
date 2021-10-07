part of mawa;

class Policies {

  getPolicyDetails(policyID) async {
  return await NetworkRequests()
        .securedMawaAPI(NetworkRequests.methodGet, resource: '${Resources.policiesResource}/$policyID');
  }

  createNewPolicy(details) async {
    return await NetworkRequests()
        .securedMawaAPI(NetworkRequests.methodPost, resource: '${Resources.policiesResource}', body: details);
  }

  searchClientPolicies(String idNumber) async {
    return await NetworkRequests()
        .securedMawaAPI(NetworkRequests.methodGet, resource: '${Resources.policiesResource}/$idNumber');
  }
}
