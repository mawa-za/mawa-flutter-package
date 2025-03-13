part of 'package:mawa_package/mawa_package.dart';

class Claim {
  Claim({
    required this.id,
  }) {
    resource = '${Resources.claim}/$id';
  }
  final String id;
  late String resource;

  //ENDPOINTS FOR THE NEW BACKEND

  claimFormDownloadPdf() async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPost,
      resource: '$resource/${Resources.claimFormPdf}',
    );
  }

  static getAll() async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: Resources.claim,
      ),
      negativeResponse: [],
    );
  }
  static getAllV2() async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: Resources.claimV2,
      ),
      negativeResponse: [],
    );
  }

  static create({
    required String claimantId,
    required String deceasedId,
    required String informantId,
    required String memberId,
    required String membershipId,
    required String type,
    required String deathDate,
    required String burialDate,
    String? paymentMethod,
    String? branch,
  }) async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPost,
      resource: Resources.claim,
      body: {
        JsonPayloads.claimantId: claimantId,
        JsonPayloads.deceasedId: deceasedId,
        JsonPayloads.informantId: informantId,
        JsonPayloads.memberId: memberId,
        JsonPayloads.membershipId: membershipId,
        JsonPayloads.type: type,
        JsonPayloads.deathDate: deathDate,
        JsonPayloads.burialDate: burialDate,
        JsonPayloads.paymentMethod: paymentMethod,
        JsonPayloads.branch: branch,
        'bankAccount': {},
      },
    );
  }

  static search({
    String? no,
    String? claimant,
    String? deceased,
    String? member,
    String? membership,
    String? type,
    String? deathDate,
    String? burialDate,
    String? status,
  }) async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: Resources.claim,
        queryParameters: {
          QueryParameters.no: no,
          QueryParameters.claimant: claimant,
          QueryParameters.member: member,
          QueryParameters.membership: membership,
          QueryParameters.type: type,
          QueryParameters.deathDate: deathDate,
          QueryParameters.burialDate: burialDate,
          QueryParameters.status: status,
          QueryParameters.deceased: deceased,
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

  delete() async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodDelete,
      resource: resource,
    );
  }

  edit({
    String? claimantId,
    String? deathDate,
    String? burialDate,
    double paidOutAmount =0.0
  }) async {
    dynamic response = await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPut,
      resource: resource,
      body: {
        JsonPayloads.claimantId: claimantId,
        JsonPayloads.deathDate: deathDate,
        JsonPayloads.burialDate: burialDate,
        JsonPayloads.paidOutAmount: paidOutAmount,
      },
    );
    return response;
  }

  dispute({
    required String claimantId,
    required String reason,
    required String comments,
  }) async {
    return await NetworkRequests().securedMawaAPI(NetworkRequests.methodPut,
        resource: '$resource/${Resources.dispute}',
        queryParameters: {
          JsonPayloads.reason: reason,
          JsonPayloads.comments: comments,
        });
  }

  cancel({
    required String claimantId,
    required String reason,
    required String comments,
  }) async {
    return await NetworkRequests().securedMawaAPI(NetworkRequests.methodPut,
        resource: '$resource/${Resources.cancel}',
        body: {
          JsonPayloads.claimId: claimantId,
          JsonPayloads.reason: reason,
          JsonPayloads.comments: comments,
        });
  }

  approve({
    String? reason,
    String? comments,
  }) async {
    return await NetworkRequests().securedMawaAPI(NetworkRequests.methodPut,
        resource: '$resource/${Resources.approve}',
        queryParameters: {
          JsonPayloads.reason: reason,
          JsonPayloads.comments: comments,
        });
  }

  reject({
    required String reason,
    required String comments,
  }) async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPut,
      resource: '$resource/${Resources.reject}',
      queryParameters: {
        JsonPayloads.statusReason: reason,
        JsonPayloads.description: comments,
      },
    );
  }

  submit() async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPut,
      resource: '$resource/${Resources.submit}',
    );
  }

  static getByMember({required String memberId}) async {
    return NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: '${Resources.submit}/${Resources.claimByMember}/$memberId',
      ),
      negativeResponse: [],
    );
  }

  // claim payment request creation
  createClaimPaymentRequest() async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPost,
        resource:'$resource/${Resources.paymentRequest}',
      ),
      negativeResponse: {},
    );
  }
}
