import 'package:mawa/services.dart';
import 'package:mawa/screens.dart';

class WorkCenters {

  static Map<String, String> workcenters = {};
  static List<String> workCentersList = [];

  getAllWorkCenters() async{
    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: Resources.workCenters);

    if(response.statusCode == 200){
      workcenters = await NetworkRequests.decodeJson(response);
    }
  }


  getWorkCenters({required String role}) async {
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

}