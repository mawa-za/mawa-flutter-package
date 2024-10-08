
import '../mawa_package.dart';

class Cases {
  late final String caseID;
  Cases(this.caseID);
  static getSpecific( String caseID,) async {
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: '${Resources.case_}/$caseID',
        ),
        negativeResponse: {});
  }
  static getAll() async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: Resources.case_,
      ),
       negativeResponse: {},
    );
  }
  static create({
    required String product,
    required String client,
    required String type,
    required String court,
    required String description,
    required List applicants,
    required List defendants,
  }) async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPost,
      resource: Resources.case_,
      body: {
        JsonPayloads.product: product,
        JsonPayloads.client: client,
        JsonPayloads.type: type,
        JsonPayloads.court: court,
        JsonPayloads.description: description,
        JsonPayloads.applicants: applicants,
        JsonPayloads.defendants: defendants,

      },
    );
  }
  static addParticipant({
    required String partner,
    required String function,
    required String caseID,
  }) async {
    return await NetworkRequests().securedMawaAPI(NetworkRequests.methodPost,
        resource: '${Resources.case_}/$caseID/${Resources.participant}',
        body: {
          JsonPayloads.partner: partner,
          JsonPayloads.function: function

        });
  }
  static deleteParticipant({required String id,partner,function}) async {
    await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodDelete,
        resource: '${Resources.case_}/$id/participant/$partner/$function'));
  }

}