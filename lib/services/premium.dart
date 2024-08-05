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
    required String membershipPeriod,
    required String tenderType,
    required String location,
    required String amount,
    required String externalReceiptNo,
  }) async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPost,
      resource: Resources.premium,
      body: {
        JsonPayloads.membershipId: membershipId,
        JsonPayloads.membershipPeriod: membershipPeriod,
        JsonPayloads.tenderType: tenderType,
        JsonPayloads.location: location,
        JsonPayloads.amount: amount,
        JsonPayloads.externalReceiptNo: externalReceiptNo,
        JsonPayloads.terminalId: ' ',
      },
    );
  }

  static search({
    String? receiptType,
    String? invoiceNumber,
    String? membershipNumber,
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
    membershipNumber != null
        ? qaramParam[QueryParameters.membershipNumber] = membershipNumber
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

  get() async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests()
          .securedMawaAPI(NetworkRequests.methodGet, resource: resource),
      negativeResponse: [],
    );
  }


}
