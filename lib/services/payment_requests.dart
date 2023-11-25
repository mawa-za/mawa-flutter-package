

import '../mawa_package.dart';

class PaymentRequests {
  //get all payments
  static getAllPayments() async {
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: '${Resources.paymentRequest}',
        ),
        negativeResponse: {});

  }

  static getSpecificPayments(String paymentId) async {
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: '${Resources.paymentRequest}/$paymentId',
        ),
        negativeResponse: {});

  }
  static makePayment(
      {
        required dynamic body
      }) async {
    dynamic response= await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPost,
        resource: Resources.paymentRequest,
        body :body
    );
    return response;
  }




}