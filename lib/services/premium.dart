part of 'package:mawa_package/mawa_package.dart';

class Premium {
  Premium({
    required this.id,
  }) {
    resource = '${Resources.premium}/$id';
  }
  final String id;
  late String resource;

  static create({
    required String membershipNumber,
    required String membershipPeriod,
    required String tenderType,
    required String location,
    required String amount,
  }) async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPost,
      resource: Resources.premium,
      body: {
        JsonPayloads.membershipNumber: membershipNumber,
        JsonPayloads.membershipPeriod: membershipPeriod,
        JsonPayloads.tenderType: tenderType,
        JsonPayloads.location: location,
        JsonPayloads.amount: amount,
        JsonPayloads.terminalId: ' ',
      },
    );
  }

  static search() async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
          resource: Resources.premium),
      negativeResponse: [],
    );
  }

  get() async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests()
          .securedMawaAPI(NetworkRequests.methodGet, resource: resource),
      negativeResponse: [],
    );
  }
}
