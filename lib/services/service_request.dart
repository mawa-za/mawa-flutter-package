
part of 'package:mawa_package/mawa_package.dart';

class ServiceRequest {
  dynamic serviceRequestID;
  ServiceRequest(this.serviceRequestID);
  //Create Ticket
  static createServiceRequest({
          required String customerId,
          required String description,
          required String category,
          required String priority}) async {
      return await NetworkRequests().securedMawaAPI(NetworkRequests.methodPost,
          resource: Resources.serviceRequest,
          body: {
            JsonPayloads.customerId: customerId,
            JsonPayloads.description: description,
            JsonPayloads.category: category,
            JsonResponses.priority: priority
          }
      );

  }

//Get specif Ticket
  getSpecifServiceRequest() async {
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
            resource: '${Resources.serviceRequest}/$serviceRequestID'),
        negativeResponse: []);
  }

  //Get All Ticket
  static getAllServiceRequest() async {
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
            resource: Resources.serviceRequest),
        negativeResponse: []);
  }


  //Delete specif Ticket
  deleteSpecifServiceRequest() async {
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(NetworkRequests.methodDelete,
            resource: '${Resources.serviceRequest}/$serviceRequestID'),
        negativeResponse: []);
  }


}
