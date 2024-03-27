import '../mawa_package.dart';

class Employment {
  dynamic partnerId;
  Employment(this.partnerId);
   static createEmployment({String ? empNo, String ? type, String ? partnerId,String ? startDate, String ? endDate, String ? branch, String ? department, String ? position }) async {
    return await NetworkRequests().securedMawaAPI(NetworkRequests.methodPost,
        resource:Resources.employment,
        body: {
          JsonPayloads.type: type,
          JsonResponses.employeeNumber:empNo,
          JsonPayloads.partnerId: partnerId,
          JsonPayloads.position: position,
          JsonPayloads.startDate: startDate,
          JsonPayloads.endDate: endDate,
          JsonPayloads.branch: branch,
          JsonPayloads.department: department,
        });
  }
  editEmployment({String ? empNo, String ? type, String ? startDate, String ? endDate, String ? branch, String ? department, String ? position }) async {
    return await NetworkRequests().securedMawaAPI(NetworkRequests.methodPut,
        resource: '${Resources.employment}/$partnerId',
        body: {
          JsonPayloads.employeeNumber: empNo,
          JsonPayloads.type: type,
          JsonPayloads.position: position,
          JsonPayloads.endDate: endDate,
          JsonPayloads.startDate:startDate,
          JsonPayloads.branch: branch,
          JsonPayloads.department: department,
        });
  }
  getSpecificEmploymentDetails() async {
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: Resources.employment,
            queryParameters: {QueryParameters.partnerId: partnerId}
        ),
        negativeResponse: {});
  }

 //get all employment history
  static getAll() async {
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: Resources.employment,
        ),
        negativeResponse: {});
  }

  terminateEmployment() async {
    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPut,
        resource: '${Resources.employment}/$partnerId/${Resources.terminate}',
    );
    return response;
  }

  rehireEmployment({required String startDate, required String endDate}) async {
    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPut,
        resource: '${Resources.employment}/$partnerId/${Resources.rehire}',
        queryParameters: {
         QueryParameters.startDate: startDate,
          QueryParameters.endDate: endDate,
        },
    );
    return response;
  }

  suspendEmployment() async {
    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPut,
        resource: '${Resources.employment}/$partnerId/${Resources.suspend}',
    );
    return response;
  }
}
