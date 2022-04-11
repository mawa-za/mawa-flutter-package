import 'package:mawa/mawa.dart';
import 'package:mawa/services/keys.dart';
import 'package:mawa/services/network_requests.dart';
import 'package:mawa/services/user.dart';

class Leaves {
  static late String leaveID;
  static late List myProfiles;
  static late List myLeaves = [];
  static late List leaveTypes;
  static List approvers = [];
  static late List pendingResponse;
  static List approverHistory = [];

  leaveProfile({required String partnerFunctionType}) async {
    String? partner;
    if (partnerFunctionType == QueryParameters.partnerFunctionEmployee) {
      partner = User.loggedInUser[JsonResponses.usersPartner];
    }
    if (partnerFunctionType == QueryParameters.partnerFunctionOrganization) {
      partner = User.loggedInUser[JsonResponses.usersGroupId];
    }

    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: Resources.leaveProfiles,
        queryParameters: {
          QueryParameters.partnerNo: partner,
          QueryParameters.partnerFunction: partnerFunctionType
        });

    // if (response.statusCode == 200) {
      myProfiles = await NetworkRequests.decodeJson(response, negativeResponse: []);
    // } else {
    //   myProfiles = [];
    // }
    return myProfiles;
  }

  getApprovers({required bool specificOrg}) async {
    approvers.clear();
    approvers =
        await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodGet,
      resource: Resources.leaves + '/' + Resources.leavesApprovers,
      queryParameters: specificOrg
          ? {
              QueryParameters.organisationId:
                  User.loggedInUser[JsonResponses.usersGroupId]
            }
          : null,
        ), negativeResponse: [],
        );

    return approvers;
  }

  getApproversHistory({required bool pending}) async {
    approverHistory.clear();
    dynamic response = await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodGet,
      resource: Resources.leaves + '/' + Resources.approversHistory,
      queryParameters: {
        QueryParameters.approverId:
            User.loggedInUser[JsonResponses.usersPartner]
      },
    );
    // if (response.statusCode == 200) {
      approverHistory = await NetworkRequests.decodeJson(response, negativeResponse: [],);
    // }

    return approverHistory;
  }

  logLeave(
      {required String approver,
      required dynamic startDate,
      dynamic endDate,
      required String leaveType,
      String? description,
      String? subDescription}) async {
    {
      dynamic response = await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodPost,
          resource: Resources.leaves,
          body: {
            JsonPayloads.loggedByID:
                User.loggedInUser[JsonResponses.usersPartner],
            JsonPayloads.approverID: approver,
            JsonPayloads.startDate: startDate.toString(),
            JsonPayloads.endDate: endDate,
            JsonPayloads.leaveType: leaveType,
            JsonPayloads.description: description,
            JsonPayloads.subDescription: subDescription,
          });
      // if (NetworkRequests.statusCode == 200 ||
      //     NetworkRequests.statusCode == 201) {
      leaveID = await NetworkRequests.decodeJson(response, negativeResponse: '');
      if(response.statusCode == 200 || response.statusCode == 201){
        Notification(id: leaveID).sendNotifications(meesageType: 'LOGLEAVE', sendToAdmin: true);
      }
      // } else {
      //   leaveID = '';
      // }
    }
  }

  pendingRequests() async {
    dynamic resp = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: Resources.leaves + '/' + Resources.leavesToApprove,
        queryParameters: {
          QueryParameters.approverId:
              User.loggedInUser[JsonResponses.usersPartner]
        });
    // print('jo\n$resp\nj');
    // if (resp.statusCode == 200 /*&& resp != null*/) {
      pendingResponse = await NetworkRequests.decodeJson(resp, negativeResponse: []);
    // } else {
    //   pendingResponse.clear();
    // }
    return pendingResponse;
  }

  leaveHistory() async {
    // myLeaves.clear();
    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: Resources.leaves,
        queryParameters: {
          QueryParameters.partnerId:
              User.loggedInUser[JsonResponses.usersPartner],
        });
    // /mawa-api/resources/leaves/?partnerId=PN0000000013
    // if (response.statusCode == 200) {
      myLeaves = await NetworkRequests.decodeJson(response, negativeResponse: []);
    // } else {
    //   myLeaves.clear();
    // }
    return myLeaves;
  }

  getLeave(String id) async {
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodGet,
      resource: Resources.leaves + '/' + id,
    ), negativeResponse: {});
  }

  Future<bool> updateLeaveStatus(
      {required String path, required String method, required String messageType}) async {
    dynamic response = await NetworkRequests().securedMawaAPI(
        method,
        resource:Resources.leaves + '/' + Leaves.leaveID + '/' + path);

    if(response.statusCode == 200 || response.statusCode == 201){
      Notification(id: leaveID).sendNotifications(meesageType: messageType, sendToAdmin: true);
    }
    return await NetworkRequests.decodeJson(response, negativeResponse: false);

    // return await NetworkRequests.decodeJson(await NetworkRequests()
    //         .securedMawaAPI(
    //             method,
    //             resource:
    //                 Resources.leaves + '/' + Leaves.leaveID + '/' + path),
    // negativeResponse: false);
  }

  editLeave(endDate) async {
    dynamic response = await NetworkRequests()
        .securedMawaAPI(NetworkRequests.methodPut,
        resource: Resources.leaves +
            '/' +
            Leaves.leaveID +
            '/' +
            Resources.edit,
        queryParameters: {QueryParameters.endDAte: endDate});
    if(response.statusCode == 200 || response.statusCode == 201){
      Notification(id: leaveID).sendNotifications(meesageType: 'APPROVEEDITED', sendToAdmin: true);
    }
    return await NetworkRequests.decodeJson(response, negativeResponse: false);
    // return await NetworkRequests.decodeJson(await NetworkRequests()
    //         .securedMawaAPI(NetworkRequests.methodPut,
    //             resource: Resources.leaves +
    //                 '/' +
    //                 Leaves.leaveID +
    //                 '/' +
    //                 Resources.edit,
    //             queryParameters: {QueryParameters.endDAte: endDate}),
    //      negativeResponse: false);
  }
}
// part of mawa;
//
// class Leaves  {
//   static late String leaveID;
//   static late List myProfiles;
//   static late List myLeaves = [];
//   static late List leaveTypes;
//   static List approvers = [];
//   static late List pendingResponse;
//
//   leaveProfile({required String partnerFunctionType}) async {
//     String? partner;
//     if(partnerFunctionType == QueryParameters.partnerFunctionEmployee){partner = User.loggedInUser[JsonResponses.usersPartner];}
//     if(partnerFunctionType == QueryParameters.partnerFunctionOrganization){partner = User.loggedInUser[JsonResponses.usersGroupId];}
//
//     dynamic response = await NetworkRequests().securedMawaAPI(
//         NetworkRequests.methodGet,
//         resource: Resources.leaveProfiles,
//         queryParameters: {
//           QueryParameters.partnerNo:partner,
//           QueryParameters.partnerFunction: partnerFunctionType
//         });
//
//     if (NetworkRequests.statusCode == 200) {
//       myProfiles = response;
//     } else {
//       myProfiles = [];
//     }
//     return myProfiles;
//   }
//
//   getApprovers({required bool specificOrg}) async {
//     approvers.clear();
//     approvers = await NetworkRequests().securedMawaAPI(
//       NetworkRequests.methodGet,
//       resource: Resources.leaves + '/' + Resources.leavesApprovers,
//       queryParameters: specificOrg ? {QueryParameters.organisationId: User.loggedInUser[JsonResponses.usersGroupId]} :null,
//     );
//
//     return approvers;
//   }
//
//   logLeave(
//       {required String approver,
//         required dynamic startDate,
//         dynamic endDate,
//         required String leaveType,
//         String? description,
//         String? subDescription
//       }) async {
//     {
//       dynamic response = await NetworkRequests().securedMawaAPI(
//           NetworkRequests.methodPost,
//           resource: Resources.leaves,
//           body: {
//             JsonPayloads.loggedByID:
//             User.loggedInUser[JsonResponses.usersPartner],
//             JsonPayloads.approverID: approver,
//             JsonPayloads.startDate: startDate.toString(),
//             JsonPayloads.endDate: endDate,
//             JsonPayloads.leaveType: leaveType,
//             JsonPayloads.description: description,
//             JsonPayloads.subDescription: subDescription,
//           });
//       if (NetworkRequests.statusCode == 200 ||
//           NetworkRequests.statusCode == 201) {
//         leaveID = response.toString();
//       } else {
//         leaveID = '';
//       }
//     }
//   }
//
//   pendingRequests() async {
//     dynamic resp  = await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
//         resource: Resources.leaves + '/' + Resources.leavesToApprove,
//         queryParameters: {
//           QueryParameters.approverId:
//           User.loggedInUser[JsonResponses.usersPartner]
//         });
//     print('jo\n$resp\nj');
//     if(NetworkRequests.statusCode == 200 /*&& resp != null*/) {
//       pendingResponse = resp;
//     }
//     else{
//       pendingResponse.clear();
//     }
//     return pendingResponse;
//   }
//
//   leaveHistory() async{
//     // myLeaves.clear();
//     dynamic response = await NetworkRequests().securedMawaAPI(
//         NetworkRequests.methodGet,
//         resource: Resources.leaves,
//         queryParameters: {
//           QueryParameters.partnerId:
//           User.loggedInUser[JsonResponses.usersPartner],
//         });
//     // /mawa-api/resources/leaves/?partnerId=PN0000000013
//     if (NetworkRequests.statusCode == 200)  {
//       myLeaves = response;
//     } else {
//       myLeaves.clear();
//     }
//     return myLeaves;
//   }
//
//   getLeave(String id) async{
//     return await NetworkRequests().securedMawaAPI(
//       NetworkRequests.methodGet,
//       resource: Resources.leaves + '/' + id,);
//   }
//
//   Future<bool> updateLeaveStatus({required String path,required String method}) async {
//     return await NetworkRequests().securedMawaAPI(
//         method,
//         resource: Resources.leaves + '/' + Leaves.leaveID + '/' + path);
//   }
//
//   editLeave(endDate) async {
//     return await NetworkRequests().securedMawaAPI(NetworkRequests.methodPut, resource: Resources.leaves + '/' + Leaves.leaveID + '/' + Resources.edit, queryParameters: {QueryParameters.endDAte: endDate}) ?? false;
//
//   }
// }
