part of mawa;

class Attachments{
  dynamic attachment;
  late List attachments;

  getAttachments({required String docType, required String parentType, required String parentReference}) async {
    attachments = await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodGet,
      resource: Resources.attachments,
      queryParameters: {
        QueryParameters.documentType:docType,
        QueryParameters.parentType:parentType,
        QueryParameters.parentReference:parentReference,
      },
    ) ?? [];
    return attachments;
  }

  viewAttachment({required String id, required String extension}) async {
    attachment = await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodGet,
      resource: Resources.attachments + '/' + id,
      queryParameters: {
        QueryParameters.extension: extension,
      }
    );
    return attachment;
  }

  ///Please note that this class is incomplete and therefore will not work accordingly or at all
  uploadAttachment({required String documentType, required String parentType, required String parentReference}) async {
    return  await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: Resources.attachments,
        body: {
          JsonPayloads.documentType: documentType,
          JsonPayloads.parentType: parentType,
          JsonPayloads.parentReference: parentReference,
        }
    );
  }

}