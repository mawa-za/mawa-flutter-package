
import '../mawa_package.dart';

class Cases {
  late final String caseID;
  Cases(this.caseID);

  static getAll() async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: 'case',
      ),
      negativeResponse: {},
    );
  }

  static getSpecific( String caseID,) async {
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: '${Resources.case_}/$caseID',
        ),
        negativeResponse: {});
  }

}