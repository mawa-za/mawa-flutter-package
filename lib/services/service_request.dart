part of 'package:mawa_package/mawa_package.dart';

class ServiceRequest {
  String id;
  ServiceRequest(this.id) {
    resource = '${Resources.serviceRequest}/$id';
  }
  late final String resource;
  //Create Ticket
  static create({
    required String customer,
    required String description,
    required String category,
    required String priority,
    String? dueDate,
    List<String>? assignees,
  }) async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPost,
        resource: Resources.serviceRequest,
        body: {
          JsonPayloads.customer: customer,
          JsonPayloads.description: description,
          JsonPayloads.category: category,
          JsonResponses.priority: priority,
          JsonResponses.dueDate: dueDate,
          JsonResponses.assignees: assignees,
        },
    );
  }

//Get specific Ticket
  get() async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: resource,
      ),
      negativeResponse: {},
    );
  }

  //Get All Ticket
  static getAll() async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: Resources.serviceRequest,
      ),
      negativeResponse: [],
    );
  }

  static search({
    String? status,
    String? customer,
    String? priority,
    String? dueDate,
    String? creationDate,
  }) async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
          resource: Resources.serviceRequest,
          queryParameters: {
            QueryParameters.status: status,
            QueryParameters.customer: customer,
            QueryParameters.priority: priority,
            QueryParameters.dueDate: dueDate,
            QueryParameters.creationDate: creationDate,
          }),
      negativeResponse: [],
    );
  }

  //Delete specific Ticket
  delete() async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodDelete,
        resource: resource,
      ),
      negativeResponse: [],
    );
  }

  edit(
      {String? description,
      String? priority,
      String? category,
      String? summary}) async {
    Map<String, String> body = {};
    if (description != null) {
      body[JsonPayloads.description] = description;
    }
    if (summary != null) {
      body[JsonPayloads.summary] = summary;
    }
    if (category != null) {
      body[JsonPayloads.category] = category;
    }
    if (priority != null) {
      body[JsonPayloads.priority] = priority;
    }
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPut,
      resource: resource,
      body: body,
    );
  }

  // assign(List<String> ids) async {
  //   return await NetworkRequests().securedMawaAPI(
  //     NetworkRequests.methodPut,
  //     resource: '$resource/${Resources.assign}',
  //     body: ids,
  //   );
  // }
  assign(List<String> ids) async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPut,
      resource: '$resource/${Resources.assign}',
      body: {JsonPayloads.assigneeIds: ids},
    );
  }

  unassign(String id) async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPut,
      resource: '$resource/${Resources.unassign}',
      body: {
        JsonPayloads.assignee: id,
      },
    );
  }

  cancel({required String statusReason, String? description}) async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPut,
      resource: '$resource/${Resources.cancel}',
      body: {
        JsonPayloads.statusReason: statusReason,
        JsonPayloads.description: description,
      },
    );
  }

  close({required String statusReason, String? description}) async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPut,
      resource: '$resource/${Resources.close}',
      body: {
        JsonPayloads.statusReason: statusReason,
        JsonPayloads.description: description,
      },
    );
  }

  reject({required String statusReason, String? description}) async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPut,
      resource: '$resource/${Resources.reject}',
      body: {
        JsonPayloads.statusReason: statusReason,
        JsonPayloads.description: description,
      },
    );
  }
}
