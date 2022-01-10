part of mawa;

class FieldOptions {
  static late Map<String, String> fieldOptions;

  getFieldOptions(String option) async {
    fieldOptions = {};
    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: Resources.fieldOptions,
        queryParameters: {
          QueryParameters.field: option,
        });
    if (NetworkRequests.statusCode == 200) {
      for (int index = 0; index < response.length;  index++) {
        fieldOptions['${response[index][JsonResponses.fieldOptionDescription]}'] = response[index][JsonResponses.fieldOptionCode];
      }
      // fieldOptions = response;
    } else {
      fieldOptions = {};
    }
    print('hooooop \n$fieldOptions');
    return fieldOptions;
  }
}