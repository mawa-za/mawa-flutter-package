part of 'package:mawa_package/mawa_package.dart';

class Membership {
  static List partnerMemberships = [];
  late final String resource;

  final String membershipID;

  Membership(this.membershipID) {
    resource = '${Resources.membership}/$membershipID';
  }

  membershipsSearch({String? partnerRole, String? idNumber}) async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: Resources.membership,
        queryParameters: {
          'idnumber': idNumber,
          QueryParameters.partnerRole: partnerRole,
        },
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
      negativeResponse: {},
    );
  }

  // {
  //   "memberId": "string",
  //   "salesRepresentativeId": "string",
  //   "productId": "string",
  //   "dateJoined": "2023-04-17T12:41:46.649Z"
  // }
  static create(Map details) async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPost,
      resource: Resources.membership,
      body: details,
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
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPut,
      resource: resource,
      body: {
        JsonPayloads.status: status,
        JsonPayloads.statusReason: statusReason,
        JsonPayloads.salesRepresentativeId:
            User.loggedInUser[JsonResponses.partner],
        JsonPayloads.premium: premium,
        JsonPayloads.productId: productId,
        JsonPayloads.previousProduct: previousProduct,
      },
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
}
