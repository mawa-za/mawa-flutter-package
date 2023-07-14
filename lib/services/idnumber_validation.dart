

import '../mawa_package.dart';

class IdentityNumberValidation{
  dynamic idNumber;
  IdentityNumberValidation(this.idNumber);
  static validateID({ required dynamic idType, required String idNumber}) async{
    dynamic response= await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodGet,
      resource: '${Resources.validate}/${Resources.identity}/$idNumber',
      queryParameters: {
        QueryParameters.type : idType,
      },

    );
    // print('response is $response');
    var isValid = await NetworkRequests.decodeJson(response, negativeResponse: '');
    print('response is $isValid');
    return isValid;
   }
  }
