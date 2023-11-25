part of 'package:mawa_package/mawa_package.dart';

class Booking {
  final String id;
  late final String resource;
  Booking(this.id) {
    resource = '${Resources.booking}/$id';
  }

 static  search({
    String? bookDate,
    String? employeeId,
    String? customerId,
    String? status,
  }) async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
          resource: Resources.booking,
          queryParameters: {
            QueryParameters.status: status,
            QueryParameters.customerId: customerId,
            QueryParameters.employeeId: employeeId,
            QueryParameters.bookDate: bookDate
          }),
      negativeResponse: [],
    );
  }

  searchById() async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: resource,
      ),
      negativeResponse: {},
    );
  }

  static create({
    required String productId,
    required String customerId,
    required String employeeId,
    required String bookDate,
    required String bookTime,
  }) async {
    return await NetworkRequests().securedMawaAPI(NetworkRequests.methodPost,
        resource: Resources.booking,
        body: {
          JsonPayloads.productId: productId,
          JsonPayloads.customerId: customerId,
          JsonPayloads.employeeId: employeeId,
          JsonPayloads.bookDate: bookDate,
          JsonPayloads.bookTime: bookTime
        });
  }

  delete() async {
    return await NetworkRequests()
        .securedMawaAPI(NetworkRequests.methodDelete, resource: resource);
  }

  edit({String? bookTime, String? bookDate, String? employeeId}) async {
    Map<String, String> payload = {};
    if (bookTime != null && bookDate != null) {
      payload[JsonPayloads.bookDate] = bookDate;
      payload[JsonPayloads.bookTime] = bookTime;
    }
    if (employeeId != null) {
      payload[JsonPayloads.employeeId] = employeeId;
    }

    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPut,
      resource: resource,
      body: payload,
    );
  }
}
