part of 'package:mawa_package/mawa_package.dart';

class GroupSociety {
  final String id;

  GroupSociety(this.id){
    resource = '${Resources.groupSociety}/$id';
  }
  late final String resource;

  static create({
    required String customer,
    required String salesRepresentative,
    required String product,
    required String salesArea,
    required String dateJoined,
  }) async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPost,
      resource: Resources.groupSociety,
      body: {
        JsonPayloads.customer: customer,
        JsonPayloads.salesRepresentative: salesRepresentative,
        JsonPayloads.product: product,
        JsonPayloads.salesArea: salesArea,
        JsonPayloads.dateJoined: dateJoined
      },
    );
  }

  static getAll() async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        // static const String groupSociety = 'group-society';
        resource: Resources.groupSociety,
      ),
    );
  }

  get() async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: resource,
      ),
    );
  }

  delete() async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodDelete,
        resource: resource,
      ),
    );
  }

  getClaims() async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: '$resource/${Resources.claims}',
      ),
      negativeResponse: [],
    );
  }

}
