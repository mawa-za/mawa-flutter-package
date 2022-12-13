part of 'package:mawa_package/mawa_package.dart';

class Notification {
//  POST /mawa-api/resources/sendNotifications/LRQ0000000055?meesageType=APPROVEDLEAVE&adminEmail=true
  late String id;

  Notification({required this.id});

  Future sendNotifications(
      {required String meesageType, required bool sendToAdmin}) async {
    return await NetworkRequests().securedMawaAPI(NetworkRequests.methodPost,
        resource: '${Resources.sendNotifications}/$id',
        queryParameters: {
          QueryParameters.meesageType: meesageType,
          QueryParameters.adminEmail: '$sendToAdmin',
        });
  }

  //POST /mawa-api/resources/sendNotifications/frankmtsi@outlook.com?meesageType=NEWUSER&user=true&password=YHqw@23a
  Future newUserNotification(
      {
        required String meesageType,
        required bool user,
        required dynamic password
}) async{
    await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPost,
        resource: Resources.sendNotifications + '/' + id,
      queryParameters: {
          QueryParameters.meesageType: meesageType,
          QueryParameters.user: user,
          QueryParameters.password: password
      });
 }

// POST /mawa-api/resources/sendNotifications/comment{
//     "id":"NOTE0000000335",
//     "email":true,
//     "sms":true,
//
//     "recievedBy":["PN0000000013","PN0000000003"
//     ]
//     }
  sendCommentNotification(List<String> receiver, {required bool email, required bool sms}) async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPost,
      resource: '${Resources.sendNotifications}/${Resources.comment}',
      body: {
        JsonPayloads.id:id,
        JsonPayloads.email:email,
        JsonPayloads.sms:sms,
        JsonPayloads.recievedBy:receiver,
      }
    );
  }
}
