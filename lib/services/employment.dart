import '../mawa_package.dart';

class Employment {
  dynamic partnerId;
  Employment(this.partnerId);
  static createEmployment({String ? empNo, String ? type, String ? startDate, String ? endDate, String ? branch, String ? department, String ? groupID, dynamic addressDtos, dynamic identityDtos, dynamic contactDtos, dynamic role, String ? position }) async {
    return await NetworkRequests().securedMawaAPI(NetworkRequests.methodPost,
        resource:Resources.employment,
        body: {
          JsonPayloads.employeeId: empNo,
          JsonPayloads.type: type,
          JsonPayloads.position: position,
          JsonPayloads.startDate: startDate,
          JsonPayloads.endDate: endDate,
          JsonPayloads.branch: branch,
          JsonPayloads.department: department,
          JsonPayloads.groupID: groupID,
          JsonPayloads.role: role,
          JsonPayloads.addressDtos:addressDtos,
          JsonPayloads.contactDtos: contactDtos,
          JsonPayloads.identityDtos: identityDtos,
        });
  }
  editEmployment({String ? empNo, String ? type, String ? startDate, String ? endDate, String ? branch, String ? department, String ? groupID, dynamic addressDtos, dynamic identityDtos, dynamic contactDtos, dynamic role, String ? position }) async {
    return await NetworkRequests().securedMawaAPI(NetworkRequests.methodPut,
        resource: '${Resources.employment}/$partnerId',
        body: {
          JsonPayloads.employeeId: empNo,
          JsonPayloads.type: type,
          JsonPayloads.position: position,
          JsonPayloads.startDate: startDate,
          JsonPayloads.endDate: endDate,
          JsonPayloads.branch: branch,
          JsonPayloads.department: department,
          JsonPayloads.groupID: groupID,
          JsonPayloads.role: role,
          JsonPayloads.addressDtos:addressDtos,
          JsonPayloads.contactDtos: contactDtos,
          JsonPayloads.identityDtos: identityDtos,
        });
  }
  getSpecificEmployeeDetails() async {
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: '${Resources.employment}/$partnerId',
        ),
        negativeResponse: {});
  }

  terminateEmployment() async {
    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPut,
        resource: '${Resources.employment}/$partnerId/${Resources.terminate}');
    return response;
  }

  rehireEmployment() async {
    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPut,
        resource: '${Resources.employment}/$partnerId/${Resources.rehire}');
    return response;
  }

  suspendEmployment() async {
    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPut,
        resource: '${Resources.employment}/$partnerId/${Resources.suspend}');
    return response;
  }
}
