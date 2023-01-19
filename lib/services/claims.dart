part of 'package:mawa_package/mawa_package.dart';

class Claims{
  Claims({required this.id});
  final String id;
  static List claims = [];

  getClaim()async{
    return await NetworkRequests.decodeJson( await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
        resource: Resources.claims,
      queryParameters: {
      QueryParameters.policy:id
      }
    ));
  }

   getAllClaims()async{
     claims.clear();
     dynamic response = await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
        resource: Resources.claims);
     claims = await NetworkRequests.decodeJson(response, negativeResponse: []);

    return claims;
  }

  getMyClaims()async{
    claims.clear();
    claims = await NetworkRequests.decodeJson( await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
        resource: Resources.claims,
        queryParameters: {
          QueryParameters.processor:'ME',
        }
    ));

    return claims;
  }

  // declineClaim(String claimNo, String value, String type)async{
  //   return await NetworkRequests().securedMawaAPI(NetworkRequests.methodPost,
  //       resource: Resources.claims + claimNo + Resources.claimDecline,
  //       body: {
  //         JsonPayloads.value: value,
  //         JsonPayloads.value:''
  //       }
  //   );
  // }

  approveClaim(String claimNo,String partnerNo)async{
    return await NetworkRequests().securedMawaAPI(NetworkRequests.methodPost,
        resource: Resources.claims + claimNo + Resources.claimApprove,
      queryParameters: {
      QueryParameters.approver:partnerNo,
      }
    );
  }

  cancelClaim(String claimNo, String note, String noteType)async{
    return await NetworkRequests().securedMawaAPI(NetworkRequests.methodPost,
        resource: Resources.claims + claimNo + Resources.claimCancel,
        body: {
          JsonPayloads.value:note,
          JsonPayloads.type:noteType
        }
    );
  }

}