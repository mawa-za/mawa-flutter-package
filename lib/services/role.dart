import '../mawa_package.dart';

class Role{

  static dynamic roleWorkcenters = [];
  static late List list = [];

  getRoleWorkcenters({required String role}) async {
    roleWorkcenters = {};
    // List
    list = await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: '${Resources.role}/$role/workcenter'));
    return list;
  }
}