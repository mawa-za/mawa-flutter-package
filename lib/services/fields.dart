part of mawa;

class Fields {
  static late List fields;
  getFields() async {
    dynamic response = await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodGet,
      resource: Resources.fields,
    );

    if (NetworkRequests.statusCode == 200) {
      return response;
    } else {
      return [];
    }
  }
}

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
        fieldOptions['${response[index][JsonResponseKeys.fieldOptionDescription]}'] = response[index][JsonResponseKeys.fieldOptionCode];
      }
      // fieldOptions = response;
    } else {
      fieldOptions = {};
    }
    print('hooooop \n$fieldOptions');
    return fieldOptions;
  }
}
