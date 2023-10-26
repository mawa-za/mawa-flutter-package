part of 'package:mawa_package/mawa_package.dart';

class Cashup {
  Cashup(this.id);
  final String id;

  static getCashupCollection({
    required String processor,
  }) async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: Resources.cashup,
        queryParameters: {
          QueryParameters.processor: processor,
        },
      ),
    );
  }

  get() async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: '${Resources.cashup}/$id',
      ),
      negativeResponse: {},
    );
  }

  edit({
    String? amountDeposited,
    String? status,
  }) async {
    Map body = {};
    if (status != null) {
      body[JsonPayloads.status] = status;
    }
    if (amountDeposited != null) {
      body[JsonPayloads.amountDeposited] = amountDeposited;
    }
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPut,
      resource: '${Resources.cashup}/$id',
      body: body,
    );
  }

  static getAll() async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: Resources.cashup,
      ),
      negativeResponse: [],
    );
  }

  static processCashup() async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPost,
      resource: Resources.cashup,
    );
  }
}