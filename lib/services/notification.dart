import 'package:mawa_package/services/keys.dart';
import 'package:mawa_package/services/network_requests.dart';

class Notification {
//  POST /mawa-api/resources/sendNotifications/LRQ0000000055?meesageType=APPROVEDLEAVE&adminEmail=true
  late String id;

  Notification({required this.id});

  Future sendNotifications(
      {required String messageType, required bool sendToAdmin}) async {
    return await NetworkRequests().securedMawaAPI(NetworkRequests.methodPost,
        resource: '${Resources.sendNotifications}/$id',
        queryParameters: {
          QueryParameters.meesageType: messageType,
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

// POST /mawa-api/resources/sendNotifications/comment
// {
//     "id":"NOTE0000000365",
//     "recievedBy":"PN0000000013"
// }
  sendCommentNotification(String receiver) async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPost,
      resource: '${Resources.sendNotifications}/${Resources.comment}',
      body: {
        JsonPayloads.id:id,
        JsonPayloads.recievedBy:receiver,
      }
    );
  }
}
