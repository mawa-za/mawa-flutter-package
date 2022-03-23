import 'package:mawa/services/keys.dart';
import 'package:mawa/services/network_requests.dart';

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
          QueryParameters.adminEmail: sendToAdmin,
        });
  }
}
