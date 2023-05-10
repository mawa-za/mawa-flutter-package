part of 'package:mawa_package/mawa_package.dart';

class Memberships {
  static dynamic membership;
  static List partnerMemberships = [];

  final String membershipID;

  Memberships(this.membershipID);

  membershipsSearch({String? partnerRole, String? idNumber}) async {
    partnerMemberships.clear();
    dynamic response = await NetworkRequests().securedMawaAPI(
            NetworkRequests.methodGet,
            resource: Resources.membership,
            queryParameters: {
              'idnumber': idNumber ??
                  Persons.person[JsonResponses.personIdNumber] ??
                  Persons.personIdNumber,
              'partnerRole': partnerRole
            }) ??
        [];
    // if(response.statusCode == 200){
    partnerMemberships =
        await NetworkRequests.decodeJson(response, negativeResponse: []);
    // }
    // else {
    //   personsPolicies = [];
    // }
    return partnerMemberships;
  }

  getMembership() async {
    membership = await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
            NetworkRequests.methodGet,
            resource: '${Resources.membership}/$membershipID'),
        negativeResponse: {},
    );
    return membership;
  }

  static getAllMembership() async {
    membership = await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
            NetworkRequests.methodGet,
            resource: Resources.membership),
        negativeResponse: {},
    );
    return membership;
  }

  // {
  //   "memberId": "string",
  //   "salesRepresentativeId": "string",
  //   "productId": "string",
  //   "dateJoined": "2023-04-17T12:41:46.649Z"
  // }
  static createNewMembership(details) async {
    return await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPost,
        resource: '${Resources.membership} ',
      body: details,);
  }

  getAttribute(String attribute) async {
    return await NetworkRequests.decodeJson(await NetworkRequests()
        .securedMawaAPI(
        NetworkRequests.methodGet,
            resource: '${Resources.membership}/$membershipID/$attribute'));
  }

  // {
  //   "memberId": "string",
  //   "member": "string",
  //   "salesRepresentativeId": "string",
  //   "salesRepresentative": "string",
  //   "productId": "string",
  //   "productDescription": "string",
  //   "premium": 0,
  //   "dateJoined": "2023-04-17T12:51:51.870Z",
  //   "dateEffective": "2023-04-17T12:51:51.870Z",
  //   "status": "string",
  //   "statusReason": "string",
  //   "mainMember": {
  //     "id": "string",
  //     "idType": "string",
  //     "idNumber": "string",
  //     "type": "string",
  //     "fullName": "string",
  //     "lastName": "string",
  //     "middleName": "string",
  //     "firstName": "string",
  //     "gender": "string",
  //     "birthDate": "string",
  //     "language": "string",
  //     "maritalStatus": "string",
  //     "title": "string",
  //     "status": "string",
  //     "statusReason": "string",
  //     "createdBy": "string",
  //     "validFrom": "string",
  //     "validTo": "string"
  //   },
  //   "salesRep": {
  //     "id": "string",
  //     "idType": "string",
  //     "idNumber": "string",
  //     "type": "string",
  //     "fullName": "string",
  //     "lastName": "string",
  //     "middleName": "string",
  //     "firstName": "string",
  //     "gender": "string",
  //     "birthDate": "string",
  //     "language": "string",
  //     "maritalStatus": "string",
  //     "title": "string",
  //     "status": "string",
  //     "statusReason": "string",
  //     "createdBy": "string",
  //     "validFrom": "string",
  //     "validTo": "string"
  //   },
  //   "dependentDtoList": [
  //     {
  //       "id": "string",
  //       "title": "string",
  //       "idType": "string",
  //       "idNumber": "string",
  //       "lastName": "string",
  //       "firstName": "string",
  //       "middleName": "string",
  //       "gender": "string"
  //     }
  //   ]
  // }
  editMembership(Map body) async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPut,
      resource: '${Resources.membership}/$membershipID',
      body: body,
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
  addDependent( {
    required Map partner
  }) async {
    return await NetworkRequests()
        .securedMawaAPI(NetworkRequests.methodPost,
            resource:
                '${Resources.membership}/$membershipID/${Resources.dependent}',
      body: partner,
    );
  }

  deleteMembership() async {
    return await NetworkRequests().securedMawaAPI(NetworkRequests.methodDelete,
        resource: '${Resources.membership}/$membershipID');
  }

  deleteDependent(String dependentId) async {
    return await NetworkRequests().securedMawaAPI(NetworkRequests.methodDelete,
        resource:
            '${Resources.membership}/$membershipID/${Resources.dependent}/$dependentId');
  }
}
