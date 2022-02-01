part of mawa;

class WorkCenters {
  static List<String> workCentersList = [];

  getWorkCenters({required String role}) async {
    role == null ? User.userLoginRole = User.userRoles[User.userRoles.keys.first]! : User.userLoginRole = role;
    List centers = NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(
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