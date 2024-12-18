part of 'package:mawa_package/mawa_package.dart';

class GroupSociety {
  final String id;

  GroupSociety(this.id) {
    resource = '${Resources.groupSociety}/$id';
  }
  late final String resource;

  static create({
    required String customer,
    required String salesRepresentative,
    required String product,
    required String salesArea,
    required String dateJoined,
    String? creationType,
    String? openingBalance,
    String? totalDeposited,
    String? totalWithdrawn,
  }) async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPost,
      resource: Resources.groupSociety,
      body: {
        JsonPayloads.customer: customer,
        JsonPayloads.salesRepresentative: salesRepresentative,
        JsonPayloads.product: product,
        JsonPayloads.salesArea: salesArea,
        JsonPayloads.dateJoined: dateJoined,
        JsonPayloads.creationType: creationType,
        JsonPayloads.openingBalance: openingBalance,
        JsonPayloads.totalDeposited: totalDeposited,
        JsonPayloads.totalWithdrawn: totalWithdrawn,
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

  static searchV2() async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: '${Resources.groupSociety}/${Resources.v2}',
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

  addRepresentative({
    required String partnerId,
    required String dateAdded,
    String? dateEffective,
  }) async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPost,
      resource: '$resource/${Resources.representative}',
      body: {
        JsonPayloads.partnerId: partnerId,
        JsonPayloads.dateAdded: dateAdded,
        JsonPayloads.dateEffective: dateEffective
      },
    );
  }

  getRepresentative() async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: '$resource/${Resources.representative}',
      ),
      negativeResponse: [],
    );
  }

  deleteRepresentative(String repID) async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodDelete,
        resource: '$resource/${Resources.representative}/$repID',
      ),
      negativeResponse: [],
    );
  }
}
