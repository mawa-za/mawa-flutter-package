part of 'package:mawa_package/mawa_package.dart';

class Premium {
  Premium({
    required this.id,
  }) {
    resource = '${Resources.premium}/$id';
  }

  final String id;
  late String resource;

  static create({
    required String membershipId,
    String? membershipPeriod,
    String? terminalId,
    required String tenderType,
    required String amount,
    String? externalReceiptNo,
    required String employeeResponsible,
  }) async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPost,
      resource: Resources.premium,
      body: {
        JsonPayloads.membershipId: membershipId,
        JsonPayloads.membershipPeriod: membershipPeriod,
        JsonPayloads.tenderType: tenderType,
        JsonPayloads.employeeResponsible: employeeResponsible,
        JsonPayloads.amount: amount,
        JsonPayloads.externalReceiptNo: externalReceiptNo,
        JsonPayloads.terminalId: terminalId,
      },
    );
  }

  static search({
    String? receiptType,
    String? invoiceNumber,
    String? membershipId,
    String? membershipPeriod,
    String? tenderType,
    String? user,
    bool? notCashed,
  }) async {
    Map<String, dynamic> qaramParam = {};
    receiptType != null
        ? qaramParam[QueryParameters.receiptType] = receiptType
        : null;
    invoiceNumber != null
        ? qaramParam[QueryParameters.invoiceNumber] = invoiceNumber
        : null;
    membershipId != null
        ? qaramParam[QueryParameters.membershipId] = membershipId
        : null;
    membershipPeriod != null
        ? qaramParam[QueryParameters.membershipPeriod] = membershipPeriod
        : null;
    tenderType != null
        ? qaramParam[QueryParameters.tenderType] = tenderType
        : null;
    user != null ? qaramParam[QueryParameters.user] = user : null;
    notCashed ??= false;
    if (notCashed) {
      qaramParam[QueryParameters.notCashed] = '$notCashed';
    }
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: '${Resources.premium}/${Resources.premiums}',
        queryParameters: qaramParam,
      ),
      negativeResponse: [],
    );
  }

  getByNumber(String query) async {
    Map<String, dynamic> queryParameters = {};
    queryParameters['query'] = query;
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: resource,
        queryParameters: queryParameters,
      ),
      negativeResponse: [],
    );
  }

  static getAll() async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: Resources.premium,
      ),
      negativeResponse: [],
    );
  }
}
