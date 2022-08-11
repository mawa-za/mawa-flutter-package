import 'package:mawa_package/services/keys.dart';
import 'package:mawa_package/services/network_requests.dart';

class FieldOptions {
  static List fieldOptions = [];
  static Map singleFieldOptions = {};

  getFieldOptions(String option) async {

    dynamic response =  await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: Resources.fieldOptions,
        queryParameters: {
          QueryParameters.field: option,
        });
      fieldOptions = await NetworkRequests.decodeJson(response, negativeResponse: []);

      return fieldOptions;
  }

  getSingleFieldOptions(String option) async {
    singleFieldOptions = {};
    await getFieldOptions(option);

      for (int index = 0; index < fieldOptions.length;  index++) {
        singleFieldOptions['${fieldOptions[index][JsonResponses.fieldOptionDescription]}'] = fieldOptions[index][JsonResponses.fieldOptionCode];
      }

    return singleFieldOptions;
  }

  addFieldOption({required option,required description}) async {
    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPost,
        resource: Resources.fieldOptions,
        body: {
          JsonPayloads.field : option,
          JsonPayloads.fieldDescription: description,
        });
  }

}
// part of mawa;
//
// class FieldOptions {
//   static late Map<String, String> fieldOptions;
//
//   getFieldOptions(String option) async {
//     fieldOptions = {};
//     dynamic response = await NetworkRequests().securedMawaAPI(
//         NetworkRequests.methodGet,
//         resource: Resources.fieldOptions,
//         queryParameters: {
//           QueryParameters.field: option,
//         });
//     if (NetworkRequests.statusCode == 200) {
//       for (int index = 0; index < response.length;  index++) {
//         fieldOptions['${response[index][JsonResponses.fieldOptionDescription]}'] = response[index][JsonResponses.fieldOptionCode];
//       }
//       // fieldOptions = response;
//     } else {
//       fieldOptions = {};
//     }
//     print('hooooop \n$fieldOptions');
//     return fieldOptions;
//   }
// }