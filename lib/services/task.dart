part of 'package:mawa_package/mawa_package.dart';

class Task {
  Task({required this.id}) {
    resource = '${Resources.task}/$id';
  }
  final String id;
  late String resource;

  static create({
    required String parentId,
    required String type,
    required String description,
    required String customerId,
    required String employeeResponsibleId,
    required String plannedStartDate,
    required String plannedEndDate,
  }) async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPost,
      resource: Resources.task,
      body: {
        JsonPayloads.parentId: parentId,
        JsonPayloads.type: type,
        JsonPayloads.description: description,
        JsonPayloads.customerId: customerId,
        JsonPayloads.employeeResponsibleId: employeeResponsibleId,
        JsonPayloads.plannedStartDate: plannedStartDate,
        JsonPayloads.plannedEndDate: plannedEndDate
      },
    );
  }

  static getAll() async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: Resources.task,
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
      negativeResponse: {},
    );
  }

  edit(
      {String? number,
      String? type,
      String? description,
      String? employeeResponsibleId,
      String? plannedStartDate,
      String? plannedEndDate,
      String? actualStartDate,
      String? actualEndDate}) async {
    await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPut,
      resource: resource,
      body: {
        JsonPayloads.type: type,
        JsonPayloads.description: description,
        JsonPayloads.employeeResponsibleId: employeeResponsibleId,
        JsonPayloads.plannedStartDate: plannedStartDate,
        JsonPayloads.plannedEndDate: plannedEndDate,
        JsonPayloads.actualStartDate: actualStartDate,
        JsonPayloads.actualEndDate: actualEndDate
      },
    );
  }

  delete() async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodDelete,
      resource: resource,
    );
  }

  static search() async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: Resources.task,
        queryParameters: {},
      ),
      negativeResponse: [],
    );
  }
}
