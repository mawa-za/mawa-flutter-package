part of 'package:mawa_package/mawa_package.dart';

class Role{
  final String role;
  Role(this.role);


  static create({required String id, required String description}) async {
    return await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPost,
        resource: Resources.role,
      body: {
          JsonPayloads.id: id,
          JsonPayloads.description: description,
      },
    );
  }

  static getAll() async {
    return await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
      resource: Resources.role,
    ),
      negativeResponse: [],
    );
  }

  getSpecific() async {
    return await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
      resource: '${Resources.role}/$role',
    ),
      negativeResponse: {}
    );
  }

  addWorkcenter({required List<String> workcenters}) async {
    return await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPost,
        resource: '${Resources.role}/$role/${Resources.workcenter}',
      body: workcenters,
    );
  }

  getWorkcenters() async {
    return await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: '${Resources.role}/$role/${Resources.workcenter}',
    ),
      negativeResponse: [],
    );
  }
}