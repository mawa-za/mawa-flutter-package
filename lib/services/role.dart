part of 'package:mawa_package/mawa_package.dart';

class Role {
  final String role;
  Role(this.role) {
    resource = '${Resources.role}/$role';
  }
  late final String resource;

  static create({String? id, required String description,}) async {
    id ??= description
          .trim()
          .replaceAll(
            ' ',
            '-',
          )
          .toUpperCase();
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
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: Resources.role,
      ),
      negativeResponse: [],
    );
  }

  get() async {
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: resource,
        ),
        negativeResponse: {});
  }

  delete() async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodDelete,
      resource: resource,
    );
  }

  addWorkcenter({required List<String> workcenters}) async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPost,
      resource: '$resource/${Resources.workcenter}',
      body: workcenters,
    );
  }

  getWorkcenters() async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: '$resource/${Resources.workcenter}',
      ),
      negativeResponse: [],
    );
  }

  deleteWorkcenter(String workcenter) async {
    return await NetworkRequests().securedMawaAPI(NetworkRequests.methodDelete,
        resource: '$resource/${Resources.workcenter}',
        queryParameters: {
          QueryParameters.workcenter: workcenter,
        },
    );
  }
}
