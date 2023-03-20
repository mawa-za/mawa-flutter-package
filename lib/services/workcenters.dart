part of 'package:mawa_package/mawa_package.dart';

class WorkCenters {

  static List workcenters = [];
  static List workCentersList = [];
  dynamic workCenId = [];
  static List workcenterRoles = [];
  dynamic roles = [];
  dynamic feedback = [];


  getAllWorkCenters() async{
    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: Resources.workcenter);
    workcenters = await NetworkRequests.decodeJson(response, negativeResponse: []);
    return workcenters;

  }

  getASingleWorkCenters() async{
    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: '${Resources.workcenter}/${Resources.workCenterDesc}');
    workCenId = await NetworkRequests.decodeJson(response, negativeResponse: []);
    print('work work work');
    return workCenId;

  }

  getWorkcenterRoles(workCenId) async{
    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: '${Resources.workcenter}/$workCenId/${Resources.roleWorkcenters}');
    workcenterRoles = await NetworkRequests.decodeJson(response, negativeResponse: []);
    print('HHHHHHHHH $workcenterRoles');
    for(int i = 0; i < workcenterRoles.length; i++) {
        roles.add(workcenterRoles[i][JsonResponses.role]);

    }

    print('roles roles $roles');

    return roles;
}

addWorkCenter({required desc, required path}) async {
  dynamic response = await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPost,
      resource: Resources.workcenter,
  body: {
        JsonPayloads.workCenterDesc : desc,
    JsonPayloads.workCenterPath : path,
  });
  return response;
}


// getWorkcenterRoles() async{
//     dynamic response = await NetworkRequests().securedMawaAPI(
//         NetworkRequests.methodGet,
//         resource: '${Resources.workCenters}/${Resources.workCenterId}/${Resources.roleWorkcenters}');
//     workcenterRoles = await NetworkRequests.decodeJson(response, negativeResponse: []);
//     print('HHHHHHHHH $workcenterRoles');
//     return workcenterRoles;
//   }

  getWorkCentersByRole({required String role, bool descOnly = false}) async {
    role == null ? User.userLoginRole = User.userRoles[User.userRoles.keys.first]! : User.userLoginRole = role;
    List centers = await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: Resources.workcenter,
        queryParameters: {'role': User.userLoginRole}
    ));
    List<String> list = [];
    if(descOnly){
      for (int i = 0; i < centers.length; i++) {
        list.add(centers[i][JsonResponses.workcenterDescription]);
      }
      workCentersList = list;
    }
    else{
      workCentersList = centers;
    }
    print('dgh  ' + workCentersList.toString());//?role=CASHIER
    return workCentersList;
  }

  addWorkCenterToRole({
    required String workCenter,
    required String position
    }) async{
    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPost,
        resource: Resources.roles +
          '/' +
          User.userLoginRole +
          '/' +
            Resources.addWorkcenter,
    body: {
          JsonPayloads.workCenter: workCenter,
          JsonPayloads.position: position
    });
    return await NetworkRequests.decodeJson(response, negativeResponse: false);
  }

  editWorkCenterRole(workCenter,position) async{
      dynamic response = await NetworkRequests().securedMawaAPI(
         NetworkRequests.methodPut,
          resource: Resources.roles +
              '/' +
              User.userLoginRole +
              '/' +
              Resources.editPosition,
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
        resource:    Resources.roles +
            '/' +
            User.userLoginRole +
            '/' +
            Resources.removeWokcenter,

        queryParameters: {
          QueryParameters.workcenter:workCenter
        });
    return await NetworkRequests.decodeJson(response, negativeResponse: false);
  }

  deleteWorkCenter(workcenter) async{
    dynamic response  = await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodDelete,
      resource: Resources.workcenter + '/' + workcenter,
    );

    feedback = await NetworkRequests.decodeJson(response, negativeResponse: []);
    print('feedback');
    print(feedback);
    print('should delete' );
    return feedback;
  }
}