part of 'package:mawa_package/mawa_package.dart';

class Comment {
  final String id;
  late final String resource;
  Comment(this.id) {
    resource = '${Resources.comment}/$id';
  }

  static create({
    required String parentTransactionId,
    required String description,
  }) async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPost,
      resource: Resources.comment,
      body: {
        JsonPayloads.parentTransactionId: parentTransactionId,
        JsonPayloads.description: description,
      },
    );
  }

  static search({
    String? parentTransactionId,
    String? createdBy,
  }) async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: Resources.comment,
        queryParameters: {
          QueryParameters.createdBy: createdBy,
          QueryParameters.parentTransactionId: parentTransactionId,
        },
      ),
      negativeResponse: [],
    );
  }

  get() async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: resource,
      ),
      negativeResponse: [],
    );
  }

  edit({
    required String parentTransactionId,
    required String description,
  }) async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPut,
      resource: resource,
      body: {
        JsonPayloads.parentTransactionId: parentTransactionId,
        JsonPayloads.description: description,
      },
    );
  }

  delete() async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodDelete,
      resource: resource,
    );
  }
}
