part of mawa;

class Leaves  {
  static late String leaveID;
  static late List myProfiles;
  static late List myLeaves = [];
  static late List leaveTypes;
  static List approvers = [];
  static late List pendingResponse;

  leaveProfile({required String partnerFunctionType}) async {
    String? partner;
    if(partnerFunctionType == QueryParameters.partnerFunctionEmployee){partner = User.loggedInUser[JsonResponses.usersPartner];}
    if(partnerFunctionType == QueryParameters.partnerFunctionOrganization){partner = User.loggedInUser[JsonResponses.usersGroupId];}

    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: Resources.leaveProfiles,
        queryParameters: {
          QueryParameters.partnerNo:partner,
          QueryParameters.partnerFunction: partnerFunctionType
        });

    if (NetworkRequests.statusCode == 200) {
      myProfiles = response;
    } else {
      myProfiles = [];
    }
    return myProfiles;
  }

  getApprovers({required bool specificOrg}) async {
    approvers.clear();
    approvers = await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodGet,
      resource: Resources.leaves + '/' + Resources.leavesApprovers,
      queryParameters: specificOrg ? {QueryParameters.organisationId: User.loggedInUser[JsonResponses.usersGroupId]} :null,
    );

    return approvers;
  }

  logLeave(
      {required String approver,
        required dynamic startDate,
        dynamic endDate,
        required String leaveType,
        String? description,
        String? subDescription
      }) async {
    {
      dynamic response = await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodPost,
          resource: Resources.leaves,
          body: {
            JsonPayloads.loggedByID:
            User.loggedInUser[JsonResponses.usersPartner],
            JsonPayloads.approverID: approver,
            JsonPayloads.startDate: startDate.toString(),
            JsonPayloads.endDate: endDate,
            JsonPayloads.leaveType: leaveType,
            JsonPayloads.description: description,
            JsonPayloads.subDescription: subDescription,
          });
      if (NetworkRequests.statusCode == 200 ||
          NetworkRequests.statusCode == 201) {
        leaveID = response.toString();
      } else {
        leaveID = '';
      }
    }
  }

  pendingRequests() async {
    dynamic resp  = await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
        resource: Resources.leaves + '/' + Resources.leavesToApprove,
        queryParameters: {
          QueryParameters.approverId:
          User.loggedInUser[JsonResponses.usersPartner]
        });
    print('jo\n$resp\nj');
    if(NetworkRequests.statusCode == 200 /*&& resp != null*/) {
      pendingResponse = resp;
    }
    else{
      pendingResponse.clear();
    }
    return pendingResponse;
  }

  leaveHistory() async{
    // myLeaves.clear();
    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: Resources.leaves,
        queryParameters: {
          QueryParameters.partnerId:
          User.loggedInUser[JsonResponses.usersPartner],
        });
    // /mawa-api/resources/leaves/?partnerId=PN0000000013
    if (NetworkRequests.statusCode == 200)  {
      myLeaves = response;
    } else {
      myLeaves.clear();
    }
    return myLeaves;
  }

  getLeave(String id) async{
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodGet,
      resource: Resources.leaves + '/' + id,);
  }

  Future<bool> updateLeaveStatus({required String path,required String method}) async {
    return await NetworkRequests().securedMawaAPI(
        method,
        resource: Resources.leaves + '/' + Leaves.leaveID + '/' + path);
  }

  editLeave(endDate) async {
    return await NetworkRequests().securedMawaAPI(NetworkRequests.methodPut, resource: Resources.leaves + '/' + Leaves.leaveID + '/' + Resources.edit, queryParameters: {QueryParameters.endDAte: endDate}) ?? false;

  }
}
