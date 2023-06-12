part of 'package:mawa_package/mawa_package.dart';

class Organisation {
  Organisation(this.id);
  final String id;

  static getAll() async {
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: Resources.organization,
        ),
        negativeResponse: []);
  }

  getSpecific() async {

    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: '${Resources.organization}/$id',
        ),
        negativeResponse: {});
  }
}
