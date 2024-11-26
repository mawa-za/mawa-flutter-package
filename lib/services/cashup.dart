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

  static getAll(String? cashUpType) async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: Resources.cashup,
        queryParameters: {
          QueryParameters.cashUpType: cashUpType,
        },
      ),
      negativeResponse: [],
    );
  }

  static searchV2({
    String? status,
    String? employeeResponsibleName,
    String? creationDate,
    String? cashUpType,
    String? idNumber,
  }) async {
    Map<String, String> query = {};
    status != null ? query[QueryParameters.status] = status : null;
    employeeResponsibleName != null
        ? query[QueryParameters.employeeResponsibleName] =
        employeeResponsibleName
        : null;
    creationDate != null
        ? query[QueryParameters.creationDate] = creationDate
        : null;
    cashUpType != null ? query[QueryParameters.cashUpType] = cashUpType : null;
    idNumber != null ? query[QueryParameters.idNumber] = idNumber : null;
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: '${Resources.cashup}/${Resources.v2}',
        queryParameters: query,
      ),
      negativeResponse: [],
    );
  }

  //Create manual receipt
  static create({
    required String employeeResponsibleId,
    required String salesArea,
    required String cashUpType,
    required List receipts,
    required String receiptFrom,
    required String receiptTo,
  }) async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPost,
      resource: Resources.cashup,
      body: {
        JsonPayloads.employeeResponsibleId: employeeResponsibleId,
        JsonPayloads.salesArea: salesArea,
        JsonPayloads.cashUpType: cashUpType,
        JsonPayloads.receiptFrom: receiptFrom,
        JsonPayloads.receiptTo: receiptTo,
        JsonPayloads.receipts: receipts,
      },
    );
  }

  //Create manual cashup
  static createManual(
      {required String employeeResponsibleId,
        required String salesArea,
        required String cashUpType,
        required String receiptFrom,
        required String receiptTo,
        double amount = 0}) async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPost,
      resource: Resources.cashup,
      body: {
        JsonPayloads.employeeResponsibleId: employeeResponsibleId,
        JsonPayloads.salesArea: salesArea,
        JsonPayloads.cashUpType: cashUpType,
        JsonPayloads.amount: amount,
        JsonPayloads.receiptFrom: receiptFrom,
        JsonPayloads.receiptTo: receiptTo,
      },
    );
  }
}
