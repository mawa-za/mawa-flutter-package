part of 'package:mawa_package/mawa_package.dart';

class Claims {
  Claims({required this.id});
  final String id;
  static List claims = [];

  getClaim() async {
    return await NetworkRequests.decodeJson(await NetworkRequests()
        .securedMawaAPI(NetworkRequests.methodGet,
            resource: Resources.claim,
            queryParameters: {QueryParameters.policy: id}));
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

  declineClaim( dynamic value) async {
    return await NetworkRequests().securedMawaAPI(NetworkRequests.methodPost,
        resource: '${Resources.claims}/$id/${Resources.claimDecline}',
        body: {
          JsonPayloads.declineReason: [
            {JsonPayloads.value: value}
          ]
        });
  }

  approveClaim() async {
    return await NetworkRequests().securedMawaAPI(NetworkRequests.methodPost,
        resource: '${Resources.claims}/$id/${Resources.claimApprove}',
        queryParameters: {
          QueryParameters.approver:
              User.loggedInUser[JsonResponses.usersPartner],
        });
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

  disputeClaim(String value) async {
    return await NetworkRequests().securedMawaAPI(NetworkRequests.methodPost,
        resource: '${Resources.claims}/$id/${Resources.refer}',
        body: {
          JsonPayloads.notes: [
            {JsonPayloads.value: value, JsonPayloads.type: "CLAIMDISPUTE"},
          ]
        });
  }

  editClaim(String claimNo,
      {String? deceasedId,
      String? claimantId,
      String? type,
      String? bankName,
      String? branchName,
      String? branchCode,
      String? accountType,
      String? accountNumber}) async {
    await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPut,
        resource: '${Resources.claims}/$claimNo',
        body: {
          JsonPayloads.deceasedId: deceasedId,
          JsonPayloads.claimantId: claimantId,
          JsonPayloads.type: type,
          JsonPayloads.bankAccount: {
            JsonPayloads.bankName: bankName,
            JsonPayloads.branchName: branchName,
            JsonPayloads.branchCode: branchCode,
            JsonPayloads.accountType: accountType,
            JsonPayloads.accountNumber: accountNumber,
          }
        }));
  }

  static submitClaim(String claimNo) async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPost,
      resource: '${Resources.claims}/$claimNo/${Resources.submit}',
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
    await NetworkRequests().securedMawaAPI(NetworkRequests.methodPost,
        resource: Resources.claim,
        body: {
          JsonPayloads.claimant: claimantId,
          JsonPayloads.deceased: deceasedId,
          JsonPayloads.member: memberId,
          JsonPayloads.membership: membershipId,
          JsonPayloads.type: type,
          JsonPayloads.deathDate: deathDate,
          JsonPayloads.burialDate: burialDate
        });
  }
}
