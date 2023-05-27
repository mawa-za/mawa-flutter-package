part of 'package:mawa_package/mawa_package.dart';

class WorkCenter {
  WorkCenter(this.code);
  final String code;

  static getAll() async{
     return await NetworkRequests.decodeJson( await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: Resources.workcenter),
         negativeResponse: []);

  }

  get() async{
    return await NetworkRequests.decodeJson( await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: '${Resources.workcenter}/$code'), negativeResponse: []);
  }

  getWorkcenterRoles(workCenId) async{
    List roles= [];
    dynamic workcenterRoles = await NetworkRequests.decodeJson( await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: '${Resources.workcenter}/$workCenId/${Resources.roleWorkcenters}'),
        negativeResponse: []);
    for(int i = 0; i < workcenterRoles.length; i++) {
        roles.add(workcenterRoles[i][JsonResponses.role]);
    }
    return roles;
}

  addWorkCenter({required desc, required path}) async {
   return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPost,
      resource: Resources.workcenter,
  body: {
        JsonPayloads.workCenterDesc : desc,
    JsonPayloads.workCenterPath : path,
  },
   );
}

 addWorkCenterToRole({
    required String workCenter,
    required String position
    }) async{
    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPost,
        resource: '${Resources.roles}/${User.userLoginRole}/${Resources.addWorkcenter}',
    body: {
          JsonPayloads.workCenter: workCenter,
          JsonPayloads.position: position
    },
    );
    return await NetworkRequests.decodeJson(response, negativeResponse: false);
  }

  editWorkCenterRole(workCenter,position) async{
      dynamic response = await NetworkRequests().securedMawaAPI(
         NetworkRequests.methodPut,
          resource: '${Resources.roles}/${User.userLoginRole}/${Resources.editPosition}',
          //'${Resources.roles}/${User.userLoginRole}/${Resources.editPosition}',
       
          queryParameters: {
           QueryParameters.workcenter:workCenter,
            QueryParameters.position:position
      });
      return await NetworkRequests.decodeJson(response, negativeResponse: false);
  }

  removeWorkCenterFromRole(workCenter) async{
    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPut,
        resource:    '${Resources.roles}/${User.userLoginRole}/${Resources.removeWokcenter}',

        queryParameters: {
          QueryParameters.workcenter:workCenter
        });
    return await NetworkRequests.decodeJson(response, negativeResponse: false);
  }

  deleteWorkCenter(workcenter) async{
    return await NetworkRequests.decodeJson( await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodDelete,
      resource: '${Resources.workcenter}/$workcenter',
    )
        , negativeResponse: []);
  }
}