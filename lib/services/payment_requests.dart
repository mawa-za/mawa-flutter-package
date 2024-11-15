

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

  //get all payment request v2
  static getAllV2() async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: Resources.paymentRequestV2
      ),
      negativeResponse: [],
    );
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

  approvePayment({required String ? paymentId, dynamic statusReason, String ? description}) async {
    return await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPut,
        resource: '${Resources.paymentRequest}/$paymentId/${Resources.approve}',
        queryParameters: {
          QueryParameters.statusReason:statusReason,
          QueryParameters.description:description,
        }
    );
  }

  rejectPayment({required String ? paymentId, dynamic  statusReason, String ? description}) async {
    return await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPut,
        resource: '${Resources.paymentRequest}/$paymentId/${Resources.reject}',
        queryParameters: {
          QueryParameters.statusReason:statusReason,
          QueryParameters.description:description,
        }
    );
  }

  cancelPayment({required String ? paymentId, dynamic statusReason, String ? description}) async {
    return await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPut,
        resource: '${Resources.paymentRequest}/$paymentId/${Resources.cancel}',
        queryParameters: {
          QueryParameters.statusReason:statusReason,
          QueryParameters.description:description,
        }
    );
  }

  completePayment({required String ? paymentId, dynamic statusReason, String ? description}) async {
    return await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPut,
        resource: '${Resources.paymentRequest}/$paymentId/${Resources.complete}',
        queryParameters: {
          QueryParameters.statusReason:statusReason,
          QueryParameters.description:description,
        }
    );
  }

  submitPayment({required String ? paymentId}) async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPut,
      resource: '${Resources.paymentRequest}/$paymentId/${Resources.submit}',
    );
  }

}