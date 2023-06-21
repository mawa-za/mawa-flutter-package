import '../mawa_package.dart';

class Employment {
  dynamic partnerId;
  Employment(this.partnerId);
   createEmployment({String ? empNo, String ? type, String ? startDate, String ? endDate, String ? branch, String ? department, String ? position }) async {
    return await NetworkRequests().securedMawaAPI(NetworkRequests.methodPost,
        resource:'${Resources.employment}/$partnerId',
        body: {
          JsonPayloads.type: type,
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
        queryParameters: {
          QueryParameters.startDate: startDate,
        },
        body: {
          JsonPayloads.type: type,
          JsonPayloads.position: position,
          JsonPayloads.endDate: endDate,
          JsonPayloads.branch: branch,
          JsonPayloads.department: department,
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

  terminateEmployment({required String startDate}) async {
    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPut,
        resource: '${Resources.employment}/$partnerId/${Resources.terminate}',
        queryParameters: {
           QueryParameters.startDate: startDate,
       },
    );
    return response;
  }

  rehireEmployment({required String startDate}) async {
    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPut,
        resource: '${Resources.employment}/$partnerId/${Resources.rehire}',
        queryParameters: {
         QueryParameters.startDate: startDate,
        },
    );
    return response;
  }

  suspendEmployment({required String startDate}) async {
    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPut,
        resource: '${Resources.employment}/$partnerId/${Resources.suspend}',
        queryParameters: {
            QueryParameters.startDate: startDate,
         },

    );
    return response;
  }
}
