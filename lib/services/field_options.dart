part of mawa;

class FieldOptions {
  static late Map<String, String> fieldOptions;

  getFieldOptions(String option) async {
    fieldOptions = {};
    print('start 1');

    dynamic response =  await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: Resources.fieldOptions,
        queryParameters: {
          QueryParameters.field: option,
        });
    print('start 2');
    if (response.statusCode == 200) {
      print('start 3');
      dynamic data = NetworkRequests.decodeJson(response);
      print('start 3.1');
      print(response);
      print(data);
      for (int index = 0; index < data.length;  index++) {
        print('start 3.1.$index a');
        fieldOptions['${data[index][JsonResponses.fieldOptionDescription]}'] = data[index][JsonResponses.fieldOptionCode];
        print('start 3.1.$index b');
      }
      print('start 4');
      // fieldOptions = response;
    } else {
      print('start 5');
      fieldOptions = {};
    }
    print('hooooop \n$fieldOptions');
    return fieldOptions;
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