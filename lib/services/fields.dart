part of 'package:mawa_package/mawa_package.dart';

class Fields {
  final String code;
  Fields(this.code) {
    resource = '${Resources.field}/$code';
  }
  static List fields = [];
  static Map singleField = {};
  late final String resource;

  static getFields() async {
    dynamic response = await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodGet,
      resource: Resources.field,
    );
    fields = await NetworkRequests.decodeJson(response, negativeResponse: []);
    return fields;
  }

  static create({
    required String desc,
    required String validFrom,
    required String validTo,
  }) async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPost,
      resource: Resources.field,
      body: {
        JsonPayloads.fieldDescription: desc,
        JsonPayloads.validFrom: validFrom,
        JsonPayloads.validTo: validTo,
      },
    );
  }

  get() async {
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: resource,
        ),
        negativeResponse: {});
  }

  mapAllFields() async {
    fields = await getFields();
    Map mappedFields = {};

    for (int index = 0; index < fields.length; index++) {
      mappedFields['${fields[index][JsonResponses.fieldOptionDescription]}'] =
          fields[index][JsonResponses.fieldOptionCode];
    }
    return mappedFields;
  }

  getOptions() async {
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: '$resource/${Resources.option}',
        ),
        negativeResponse: []);
  }

  mapFieldsOptions() async {
    dynamic options = await getOptions();
    Map<String, String> mappedFields = {};
    for (int index = 0; index < options.length; index++) {
      mappedFields['${options[index][JsonResponses.fieldOptionDescription]}'] =
          options[index][JsonResponses.fieldOptionCode].toString();
    }
    return mappedFields;
  }

  // {
  //   "field": "string",
  //   "code": "string",
  //   "description": "string",
  //   "validFrom": "2023-05-24T06:45:41.716Z",
  //   "validTo": "2023-05-24T06:45:41.716Z"
  // }
  createOption({
    required String description,
    required String validFrom,
    required String validTo,
  }) async {
    description = Strings.description(description);
    String code = description.trim().replaceAll(' ', '-').toUpperCase();
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPost,
      resource: '$resource/${Resources.option}',
      body: {
        JsonPayloads.field: this.code,
        JsonPayloads.code: code,
        JsonPayloads.description: description,
        JsonPayloads.validFrom: validFrom,
        JsonPayloads.validTo: validTo,
      },
    );
  }

  deleteOption(String fieldOption) async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodDelete,
      resource: '$resource/${Resources.option}',
      queryParameters: {
        QueryParameters.fieldOption: fieldOption,
      },
    );
  }
}
