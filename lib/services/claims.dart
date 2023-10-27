part of 'package:mawa_package/mawa_package.dart';

class Claims {
  Claims({required this.id});
  final String id;
  static List claims = [];

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
          QueryParameters.deceased: deceased,
          QueryParameters.member: member,
          QueryParameters.membership: membership,
          QueryParameters.type: type,
          QueryParameters.deathDate: deathDate,
          QueryParameters.burialDate: burialDate,
          QueryParameters.status: status,
          QueryParameters.filter: QueryParameters.filterValue,
        },
      ),
    );
  }

  getMyClaims() async {
    claims.clear();
    claims = await NetworkRequests.decodeJson(await NetworkRequests()
        .securedMawaAPI(NetworkRequests.methodGet,
            resource: Resources.claims,
            queryParameters: {
          QueryParameters.processor: 'ME',
        }));

    return claims;
  }

  rejectClaim({String? statusReason, String? description}) async {
    return await NetworkRequests().securedMawaAPI(NetworkRequests.methodPut,
        resource: '${Resources.claim}/$id/${Resources.reject}',
        queryParameters: {
          QueryParameters.statusReason: statusReason,
          QueryParameters.description: description,
        });
  }

  approveClaim() async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPut,
      resource: '${Resources.claim}/$id/${Resources.approve}',
      // queryParameters: {
      //   QueryParameters.approver:
      //       User.loggedInUser[JsonResponses.usersPartner],
      // }
    );
  }

  cancelClaim(String value) async {
    return await NetworkRequests().securedMawaAPI(NetworkRequests.methodPost,
        resource: '${Resources.claims}/$id/${Resources.claimCancel}',
        body: {
          JsonPayloads.notes: [
            {JsonPayloads.value: value, JsonPayloads.type: "CANCELCLAIM"},
          ]
        });
  }

  getSpecificClaim() async {
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: '${Resources.claim}/$id',
        ),
        negativeResponse: {});
  }

  disputeClaim({String? statusReason, String? description}) async {
    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPut,
        resource: '${Resources.claim}/$id/${Resources.dispute}',
        queryParameters: {
          QueryParameters.statusReason: statusReason,
          QueryParameters.description: description,
        });
    return response;
  }

  static submitClaim(String claimNo) async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPut,
      resource: '${Resources.claim}/$claimNo/${Resources.submit}',
    );
  }

  static submitDocuments(String claimNo) async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPost,
      resource: '${Resources.claims}/$claimNo/${Resources.submitted}',
    );
  }

  //ENDPOINTS FOR THE NEW BACKEND

  static getClaims() async {
    claims.clear();
    dynamic response = await NetworkRequests()
        .securedMawaAPI(NetworkRequests.methodGet, resource: Resources.claim);
    claims = await NetworkRequests.decodeJson(response, negativeResponse: []);

    return claims;
  }

  static createClaim({
    required String claimantId,
    required String deceasedId,
    required String memberId,
    required String membershipId,
    required String type,
    required String deathDate,
    required String burialDate,
  }) async {
    return await NetworkRequests().securedMawaAPI(NetworkRequests.methodPost,
        resource: Resources.claim,
        body: {
          JsonPayloads.claimantId: claimantId,
          JsonPayloads.deceasedId: deceasedId,
          JsonPayloads.memberId: memberId,
          JsonPayloads.membershipId: membershipId,
          JsonPayloads.type: type,
          JsonPayloads.deathDate: deathDate,
          JsonPayloads.burialDate: burialDate
        });
  }

  static addBankingDetails({
    required String accountHolder,
    required String bankName,
    required String accountNumber,
    required String branchCode,
    required String? accountType,
    required String transaction,
  }) async {
    return await NetworkRequests().securedMawaAPI(NetworkRequests.methodPost,
        resource: '${Resources.claim}/bankDetails',
        body: {
          JsonPayloads.accountHolder: accountHolder,
          JsonPayloads.bankName: bankName,
          JsonPayloads.accountNumber: accountNumber,
          JsonPayloads.branchCode: branchCode,
          JsonPayloads.accountType: accountType,
          JsonPayloads.transaction: transaction,
        });
  }

  static newClaim({required dynamic body}) async {
    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPost,
        resource: Resources.claim,
        body: body);
    return response;
  }

  static editClaim({required dynamic body, required String claimNumber}) async {
    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPut,
        resource: '${Resources.claim}/$claimNumber/${Resources.dispute}',
        body: body);
    return response;
  }
  static disputeClaimNew({
    required String claimantId,
    required String reason,
    required String comments,


  }) async {
    return await NetworkRequests().securedMawaAPI(NetworkRequests.methodPut,
        resource: '${Resources.claim}/$claimantId/${Resources.dispute}',
        body: {
          JsonPayloads.claimId: claimantId,
          JsonPayloads.reason: reason,
          JsonPayloads.comments: comments,

        });
  }
}
