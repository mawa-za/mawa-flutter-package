part of 'package:mawa_package/mawa_package.dart';

class Notifications {
  late String id;
  Notifications({ required this.id});
  createNotification( {required String transactionId, required String processorId, required String recipientId, required String subType} ) async{
    return await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPost,
        resource: Resources.notifications,
        body: {
          JsonPayloads.transaction:transactionId,
          JsonPayloads.processor:processorId,
          JsonPayloads.recipient:recipientId,
          JsonPayloads.subType:subType,
        }
    );
  }

  openNotification() async{
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPut,
      resource: '${Resources.notifications}/$id/${Resources.read}',
    );
  }

  static getPartnerNotification(String userId ) async{
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: '${Resources.notifications}/$userId/${Resources.partner}',
        ),
        negativeResponse: {});
  }

  getNotificationByTransaction() async{
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: '${Resources.notifications}/$id/${Resources.byTrans}',
        ),
        negativeResponse: {});
  }




}