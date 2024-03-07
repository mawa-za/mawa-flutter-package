part of 'package:mawa_package/mawa_package.dart';

class ServiceRequest {
  String id;
  ServiceRequest(this.id) {
    resource = '${Resources.serviceRequest}/$id';
  }
  late final String resource;
  //Create Ticket
  static create({
    required String customerId,
    required String description,
    required String category,
    required String priority,
  }) async {
    return await NetworkRequests().securedMawaAPI(NetworkRequests.methodPost,
        resource: Resources.serviceRequest,
        body: {
          JsonPayloads.customerId: customerId,
          JsonPayloads.description: description,
          JsonPayloads.category: category,
          JsonResponses.priority: priority
        });
  }

//Get specif Ticket
  get() async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: resource,
      ),
      negativeResponse: [],
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

  //Delete specif Ticket
  delete() async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodDelete,
        resource: resource,
      ),
      negativeResponse: [],
    );
  }

  edit() async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPut,
        resource: resource,
      ),
      negativeResponse: [],
    );
  }
}
