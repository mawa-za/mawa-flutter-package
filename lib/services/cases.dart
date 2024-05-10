
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
        resource: 'case',
      ),
      negativeResponse: {},
    );
  }

  static create({
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
        JsonPayloads.client: client,
        JsonPayloads.type: type,
        JsonPayloads.court: court,
        JsonPayloads.description: description,
        JsonPayloads.applicants: applicants,
        JsonPayloads.defendants: defendants,

      },
    );
  }


}