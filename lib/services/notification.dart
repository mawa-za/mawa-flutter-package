import 'package:mawa_package/services/keys.dart';
import 'package:mawa_package/services/network_requests.dart';

class Notification {
//  POST /mawa-api/resources/sendNotifications/LRQ0000000055?meesageType=APPROVEDLEAVE&adminEmail=true
  late String id;

  Notification({required this.id});

  Future sendNotifications(
      {required String meesageType, required bool sendToAdmin}) async {
    await NetworkRequests().securedMawaAPI(NetworkRequests.methodPost,
        resource: Resources.sendNotifications + '/' + id,
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
}
