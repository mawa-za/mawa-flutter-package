
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
    required String client,
    required type,
    required String description,
  }) async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPost,
      resource: Resources.case_,
      body: {
        JsonPayloads.client: client,
        JsonPayloads.type: type,
        JsonPayloads.description: description,

      },
    );
  }
  static addParticipant({
    required String partner,
    required String function,
    required String caseID,
    String? representativeID,
  }) async {
    dynamic postBody={};
    if(representativeID!=null)
    {
      postBody={
        JsonPayloads.partner: partner,
        JsonPayloads.function: function,
        JsonPayloads.legalRepresentative: representativeID
      };
    }else
    {
      postBody={
        JsonPayloads.partner: partner,
        JsonPayloads.function: function
      };
    }
    return await NetworkRequests().securedMawaAPI(NetworkRequests.methodPost,
        resource: '${Resources.case_}/$caseID/${Resources.participant}',
        body: postBody
    );
  }
  static deleteParticipant({required String id,partner,function}) async {
    await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodDelete,
        resource: '${Resources.case_}/$id/participant/$partner/$function'));
  }

}