import '../mawa_package.dart';

class Address {

  late String objectId;
  Address(this.objectId);

  //get all
  static getAllAddress({required String objectId}) async {
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: Resources.address,
            queryParameters: {
              QueryParameters.objectId: objectId,
            }
        ),
        negativeResponse: {});
  }
  //get specific address

  getSpecificAddress({required String addressId}) async {
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: '${Resources.address}/$addressId',
        ),
        negativeResponse: {});
  }

  //add address
   addAddress({
    required String addressType,
    String ? line1,
    String ? line2,
    String ? line3,
    String ?line4,
    String ?suburb,
    String ?town,
    String ? city,
    String ? province,
    String ? postalCode,

  }) async {
    return await NetworkRequests().securedMawaAPI(NetworkRequests.methodPost,
        resource: Resources.address,
        body: {
          JsonPayloads.objectId: objectId,
          JsonPayloads.type: addressType,
          JsonPayloads.line1: line1,
          JsonPayloads.line2: line2,
          JsonPayloads.line3: line3,
          JsonPayloads.line4: line4,
          JsonPayloads.suburb: suburb,
          JsonPayloads.city:city,
          JsonPayloads.town: town,
          JsonPayloads.province: province,
          JsonPayloads.postalCode: postalCode

        });
  }

  //edit address
 editAddress({
    required String addressId,
    String ? line1,
    String ? line2,
    String ? line3,
    String ? line4,
    String ? suburb,
    String ? town,
    String ? city,
    String ? province,
    String ? postalCode,

  }) async {
    return await NetworkRequests().securedMawaAPI(NetworkRequests.methodPut,
        resource:'${Resources.address}/$addressId',
        body: {
          JsonPayloads.id: addressId,
          JsonPayloads.line1: line1,
          JsonPayloads.line2: line2,
          JsonPayloads.line3: line3,
          JsonPayloads.line4: line4,
          JsonPayloads.suburb: suburb,
          JsonPayloads.city:city,
          JsonPayloads.town: town,
          JsonPayloads.province: province,
          JsonPayloads.postalCode: postalCode

        });
  }

  //delete address by transaction
  static deleteAddress({required String addressId}) async {
    await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodDelete, resource: '${Resources.address}/$addressId',
       ),
    );
  }




}