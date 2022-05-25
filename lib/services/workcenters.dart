import 'package:mawa/services.dart';
import 'package:mawa/screens.dart';

class WorkCenters {

  static Map<String, String> workcenters = {};
  static List<String> workCentersList = [];

  getAllWorkCenters() async{
    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: Resources.workCenters);
  }

  getWorkCentersByRole({required String role}) async {
    role == null ? User.userLoginRole = User.userRoles[User.userRoles.keys.first]! : User.userLoginRole = role;
    List centers = await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: Resources.workCenters,
        queryParameters: {'role': User.userLoginRole}
    ));
    List<String> list = [];
    for (int i = 0; i < centers.length; i++) {
      list.add(centers[i][JsonResponses.workCenter]);
    }
    workCentersList = list;
    print('dgh  ' + workCentersList.toString());//?role=CASHIER
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
          resource:    Resources.roles +
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

}