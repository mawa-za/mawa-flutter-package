part of 'package:mawa_package/mawa_package.dart';

class Partners {
  static List partner = [];
  late String partnerId;
  dynamic isValid;
  Partners(this.partnerId);

  static search({String? role,String?attributeName,String?attributeValue, String? type,}) async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
          resource: Resources.partner,
          queryParameters: {
            QueryParameters.role: role,
            QueryParameters.attributeName: attributeName,
            QueryParameters.attributeValue: attributeValue,
            QueryParameters.type: type,
          },
      ),
      negativeResponse: [],
    );
  }
  static searchV2({String? role,String?attributeName,String?attributeValue, String? type,}) async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
        resource: Resources.partnerV2,
        queryParameters: {
          QueryParameters.role: role,
          QueryParameters.attributeName: attributeName,
          QueryParameters.attributeValue: attributeValue,
          QueryParameters.type: type,
        },
      ),
      negativeResponse: [],
    );
  }
  static newSearch({String? role,String? pageSize ,String? pageNumber,String?attributeName,String?attributeValue, String? type,}) async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
        resource: Resources.newPartner,
        queryParameters: {
          QueryParameters.role: role,
          QueryParameters.pageSize: pageSize,
          QueryParameters.pageNumber: pageNumber,

        },
      ),
      negativeResponse: [],
    );
  }
  static createPartner({required dynamic body}) async {
    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPost,
        resource: Resources.partner,
        body: body);
    return response;
  }

  editPartner({required dynamic body}) async {
    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPut,
        resource: '${Resources.partner}/$partnerId',
        body: body);
    return response;
  }

  Future assignPersonRole({required String partnerRole}) async {
    await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPost,
        resource: '${Resources.partner}/$partnerId/${Resources.assign}',
        queryParameters: {QueryParameters.role: partnerRole}));
  }

  static getSpecificPartner(String partnerId) async {
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: '${Resources.partner}/$partnerId',
        ),
        negativeResponse: {});
  }

  getPartnerDetails({required String path}) async {
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: '${Resources.partner}/$partnerId/$path',
        ),
        negativeResponse: {});
  }

  getSpecificPartnerAddress({String? path, String? type}) async {
    await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPost,
        resource: '${Resources.partner}/$path',
        queryParameters: {QueryParameters.type: type}));
  }

  addIdentity({
    String? path,
    String? idType,
    String? idNumber,
    String? validFrom,
    String? validTo,
  }) async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPost,
      resource: '${Resources.partner}/$partnerId/$path',
      body: {
        JsonPayloads.type: idType,
        JsonPayloads.number: idNumber,
        JsonPayloads.validFrom: validFrom,
        JsonPayloads.validTo: validTo,
      },
    );
  }

  addContact({String? path, String? contactType, dynamic detail}) async {
    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPost,
        resource: '${Resources.partner}/$partnerId/$path',
        body: {
          JsonPayloads.type: contactType,
          JsonPayloads.value: detail,
        });
    return response;
  }

  addAdress(
      {String? path,
      String? addressType,
      String? houseno,
        String? partnerId,
      String? streetName,
      dynamic suburb,
      dynamic city,
      String? postalCode}) async {
    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPost,
        resource: '${Resources.partner}/$partnerId/$path',
        body: {
          JsonPayloads.partner: partnerId,
          JsonPayloads.type: addressType,
          JsonPayloads.addressline1: houseno,
          JsonPayloads.addressline2: streetName,
          JsonPayloads.addressline3: suburb,
          JsonPayloads.addressline4: city,
          JsonPayloads.postalCode: postalCode,
        });
    return response;
  }

  addBankDetails(
      {String? path,
         dynamic accType,
         String? accountHolder,
         String? accountNumber,
         String ? branchCode,
         dynamic bankName,
         branchName,
        String? postalCode}) async {
    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPost,
        resource: '${Resources.partner}/$partnerId/$path',
        body: {
          JsonPayloads.accountType: accType,
          JsonPayloads.accountHolder: accountHolder,
          JsonPayloads.accountNumber: accountNumber,
          JsonPayloads.bankName: bankName,
          JsonPayloads.branchName: branchName,
          JsonPayloads.branchCode: branchCode,
        });
    return response;
  }
  // Get Bank Details
  getPartnerBankDetails({String? path}) async {
    return await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: '${Resources.partner}/$partnerId/$path'
     )
    );
  }


  deleteAddress({String? path, dynamic addressId, String? type}) async {
    await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodDelete,
        resource: '${Resources.partner}/$partnerId/$path/$addressId',
        queryParameters: {
          QueryParameters.addressId: addressId,
          QueryParameters.type: type
        }));
  }

  deleteContact({String? path, String? type}) async {
    await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodDelete,
        resource: '${Resources.partner}/$partnerId/$path',
        queryParameters: {QueryParameters.type: type}));
  }

  deleteRole({String? path, String? role}) async {
    await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodDelete,
        resource: '${Resources.partner}/$partnerId/$path',
        queryParameters: {QueryParameters.role: role}));
  }

  static deleteIdentity(
      {String? path, String? idType, String? idNumber}) async {
    await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodDelete,
        resource: '${Resources.partner}/$path',
        queryParameters: {
          QueryParameters.idType: idType,
          QueryParameters.idNumber: idNumber,
        }));
  }

  static deleteAccount({required String id}) async {
    await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodDelete,
        resource: '${Resources.partner}/$id/${PartnerAttributes.bank}'));
  }

  editIdentity(
      {String? idNumber,
      String? validTo,
      String? validFrom,
      String ? partnerId,
      required String? path,
      required String? idType
      }) async {
    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPut,
        resource: '${Resources.partner}/$partnerId/$path',
        body: {
          JsonPayloads.partner:partnerId,
          JsonPayloads.type : idType,
          JsonPayloads.number: idNumber,
          JsonPayloads.validTo: validTo,
          JsonPayloads.validFrom: validFrom
        });
    return response;
  }

  editContact({
    String? value,
    String? validTo,
    String? validFrom,
    String? type,
    required String? path,
  }) async {
    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPut,
        resource: '${Resources.partner}/$partnerId/$path',
        queryParameters: {
          QueryParameters.contactType: type,
        },
        body: {
          JsonPayloads.value: value,
          JsonPayloads.validTo: validTo,
          JsonPayloads.validFrom: validFrom
        });
    return response;
  }

  editAddress(
      {
        String? id,
        String? houseNo,
        String? streetName,
        String? suburb,
        String? city,
        String? postalCode,
        dynamic addressId,
        required String? path,
        dynamic idType}) async {
    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPut,
        resource: '${Resources.partner}/$partnerId/$path/$addressId',
        body: {
          JsonPayloads.id: id,
          JsonPayloads.line1: houseNo,
          JsonPayloads.line2: streetName,
          JsonPayloads.line3: suburb,
          JsonPayloads.line4: city,
          JsonPayloads.postalCode: postalCode
        });
    return response;
  }

  static editBankDetails(
      { required dynamic id,
        String? accHolderName,
        dynamic bankName,
        String? accType,
        String? accNumber,
        dynamic branchName,
        String? branchCode,
        String? validFrom,
        String? validTo
      }) async {
    return await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPut,
        resource: '${Resources.partner}/$id/${PartnerAttributes.bank}',
        body: {
          JsonPayloads.accountHolder: accHolderName,
          JsonPayloads.bankName: bankName,
          JsonPayloads.accountType: accType,
          JsonPayloads.accountNumber: accNumber,
          JsonPayloads.branchName: branchName,
          JsonPayloads.branchCode: branchCode,
          JsonPayloads.validFrom: validFrom,
          JsonPayloads.validTo: validTo
        });

  }

  static getSpecifIdentity(
      {required String path,
      required String idNumber,
      required String idType}) async {
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: '${Resources.partner}/$path',
          queryParameters: {
            QueryParameters.idType: idType,
            QueryParameters.idNumber: idNumber,
          },
        ),
        negativeResponse: []);
  }

  getPartnerSpecifIdentity(
      {required String path,
      required String idNumber,
      required String idType}) async {
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: '${Resources.partner}/$partnerId/$path',
          queryParameters: {
            QueryParameters.idType: idType,
            QueryParameters.idNumber: idNumber,
          },
        ),
        negativeResponse: []);
  }

  static getSpecifContact(
      {required String path,
      required String value,
      required String type}) async {
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: '${Resources.partner}/$path',
          queryParameters: {
            QueryParameters.type: type,
            QueryParameters.value: value,
          },
        ),
        negativeResponse: []);
  }

  getPartnerSpecifContact(
      {required String path,
      required String value,
      required String type}) async {
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: '${Resources.partner}/$partnerId/$path',
          queryParameters: {
            QueryParameters.type: type,
            QueryParameters.value: value,
          },
        ),
        negativeResponse: []);
  }

  static getSpecifAddress(
      {required String path, required String addressType}) async {
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: '${Resources.partner}/$path',
          queryParameters: {QueryParameters.type: addressType},
        ),
        negativeResponse: []);
  }

  getPartnerSpecifAddress(
      {required String path, required String addressType}) async {
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: '${Resources.partner}/$partnerId/$path',
          queryParameters: {
            QueryParameters.type: addressType,
          },
        ),
        negativeResponse: []);
  }

  assignPartnerRole({required String path, dynamic body}) async {
    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPost,
        resource: '${Resources.partner}/$partnerId/$path',
        body: body);
    return response;
  }

  get() async {
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: '${Resources.partner}/$partnerId',
        ),
        negativeResponse: {});
  }

  static getAll() async {
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: Resources.partner,
        ),
        negativeResponse: []);
  }

  //Archive customer
  archiveCustomer() async {
    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPut,
        resource: '${Resources.partner}/$partnerId/${Resources.archive}');
    return response;
  }

  //UnArchive customer
  unArchiveCustomer() async {
    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPut,
        resource: '${Resources.partner}/$partnerId/${Resources.unarchive}');
    return response;
  }

  //Attribute methods
  static createAttribute({
    required String partner,
    required String attribute,
    required String value,
  }) async {
    return await NetworkRequests().securedMawaAPI(NetworkRequests.methodPost,
        resource: '${Resources.partner}/$partner/${Resources.attribute}',
        body: {
          JsonPayloads.partner: partner,
          JsonPayloads.attribute: attribute,
          JsonPayloads.attributeValue: value,
        });
  }
  getAttribute() async{
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodGet,
      resource: '${Resources.partner}/$partnerId/${Resources.attribute}',
    ),
    negativeResponse: [],
    );
  }

}
