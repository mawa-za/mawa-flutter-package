part of 'package:mawa_package/mawa_package.dart';

class Membership {
  static List partnerMemberships = [];
  late final String resource;

  final String membershipID;

  Membership(this.membershipID) {
    resource = '${Resources.membership}/$membershipID';
  }


  getMembershipInvoices() async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: '${Resources.membership}/$membershipID/${Resources.invoice}',
      ),
      negativeResponse: [],
    );
  }


  static search({
    String? partnerRole,
    String? partnerFunction,
    String? idNumber,
    String? status,
  }) async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: Resources.membership,
        queryParameters: {
          QueryParameters.partnerNo: partnerRole,
          QueryParameters.partnerFunction: partnerFunction,
          QueryParameters.idNumber: idNumber,
          QueryParameters.status: status,
        },
      ),
      negativeResponse: [],
    );
  }

  static searchV2({
    String? status,
    String? mainPartner,
    String? employeeResponsibleName,
    String? creationDate,
    String? idNumber,
  }) async {
    Map<String, String> param = {};
    status != null ? param[QueryParameters.status] = status : null;
    mainPartner != null
        ? param[QueryParameters.mainPartner] = mainPartner
        : null;
    employeeResponsibleName != null
        ? param[QueryParameters.employeeResponsibleName] =
            employeeResponsibleName
        : null;
    creationDate != null
        ? param[QueryParameters.creationDate] = creationDate
        : null;
    idNumber != null ? param[QueryParameters.idNumber] = idNumber : null;
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: '${Resources.membership}/${Resources.v2}',
        queryParameters: param,
      ),
      negativeResponse: [],
    );
  }

  get() async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: resource,
      ),
      negativeResponse: {},
    );
  }

  static getAll() async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: Resources.membership,
      ),
      negativeResponse: [],
    );
  }

  // {
  //   "memberId": "string",
  //   "salesRepresentativeId": "string",
  //   "productId": "string",
  //   "dateJoined": "2023-04-17T12:41:46.649Z"
  // }
  static create({
    required String membershipType,
    required String memberId,
    required String salesRepresentativeId,
    required String productId,
    required String creationType,
    String? salesArea,
    required String dateJoined,
    String? prevInsurer,
    String? lastReceiptDate,
    String? currentMembershipId,
  }) async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPost,
      resource: Resources.membership,
      body: {
        JsonPayloads.membershipType: membershipType,
        JsonPayloads.memberId: memberId,
        JsonPayloads.productId: productId,
        JsonPayloads.salesArea: salesArea,
        JsonPayloads.salesRepresentativeId: salesRepresentativeId,
        JsonPayloads.dateJoined: dateJoined,
        JsonPayloads.creationType: creationType,
        JsonPayloads.previousInsurerId: prevInsurer,
        JsonPayloads.lastReceiptDate: lastReceiptDate,
        JsonPayloads.currentMembershipId: currentMembershipId,
      },
    );
  }

  getAttribute(String attribute) async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: '$resource/$attribute',
      ),
    );
  }

  //  {
  //   "status": "string",
  //   "statusReason": "string",
  //   "salesRepresentativeId": "string",
  //   "premium": 0,
  //   "productId": "string",
  //   "previousProduct": "string"
  // }
  edit({
    String? status,
    String? statusReason,
    String? premium,
    String? productId,
    String? previousProduct,
  }) async {
    Map<String, dynamic> person = Map<String, dynamic>.from(
      await jsonDecode(
        await SharedStorage.getString(SharedPrefs.loggedInUser) ?? '{}',
      ),
    );
    Map<String, String> payload = {
      JsonPayloads.salesRepresentativeId:
          person[JsonResponses.partnerId] ?? person[JsonResponses.username],
    };
    status != null ? payload[JsonPayloads.status] = status : null;
    statusReason != null
        ? payload[JsonPayloads.statusReason] = statusReason
        : null;
    premium != null ? payload[JsonPayloads.premium] = premium : null;
    productId != null ? payload[JsonPayloads.productId] = productId : null;
    previousProduct != null
        ? payload[JsonPayloads.previousProduct] = previousProduct
        : null;
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPut,
      resource: resource,
      body: payload,
    );
  }

  // {
  //   "id": "string",
  //   "title": "string",
  //   "idType": "string",
  //   "idNumber": "string",
  //   "lastName": "string",
  //   "firstName": "string",
  //   "middleName": "string",
  //   "gender": "string"
  // }
  addDependent({required Map partner}) async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPost,
      resource: '$resource/${Resources.dependent}',
      body: partner,
    );
  }

  getDependent() async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: '$resource/${Resources.dependent}',
      ),
      negativeResponse: [],
    );
  }

  delete() async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodDelete,
      resource: resource,
    );
  }

  deleteDependent(String dependentId) async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodDelete,
      resource: '$resource/${Resources.dependent}/$dependentId',
    );
  }

  getClaims() async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: '$resource/${Resources.claims}',
      ),
      negativeResponse: [],
    );
  }

  addTombstoneRecipient({required String partnerId}) async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPost,
      resource: '$resource/${Resources.tombstoneRecipient}/$partnerId',
    );
  }

  deleteTombstoneRecipient(String recipientId) async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodDelete,
      resource: '$resource/${Resources.tombstoneRecipient}/$recipientId',
    );
  }

  getTombstoneRecipient() async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: '$resource/${Resources.tombstoneRecipient}',
      ),
      negativeResponse: [],
    );
  }

  activate({required String statusReason, String? description}) async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPost,
      resource: '$resource/${Resources.activate}',
      body: {
        JsonPayloads.statusReason: statusReason,
        JsonPayloads.description: description,
      },
    );
  }

  deactivate({required String statusReason, String? description}) async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPost,
      resource: '$resource/${Resources.deactivate}',
      body: {
        JsonPayloads.statusReason: statusReason,
        JsonPayloads.description: description,
      },
    );
  }

  cancel({required String statusReason, String? description}) async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPost,
      resource: '$resource/${Resources.cancel}',
      body: {
        JsonPayloads.statusReason: statusReason,
        JsonPayloads.description: description,
      },
    );
  }
}
