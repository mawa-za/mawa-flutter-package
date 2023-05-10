part of 'package:mawa_package/mawa_package.dart';

class Fields {
  final String code;
  Fields(this.code);
  static List fields = [];
  static Map singleField = {};

  static getFields() async {
    dynamic response =await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodGet,
      resource: Resources.field,
    );
      fields = await NetworkRequests.decodeJson(response, negativeResponse: []);
      return fields;

  }

  static addField({
    required String desc,
    required String validFrom,
    required String validTo,
  }) async {
    return await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPost,
        resource: Resources.field,
        body: {
          JsonPayloads.fieldDescription : desc,
          JsonPayloads.validFrom : validFrom,
          JsonPayloads.validTo : validTo,
        },
    );
  }

  getSingleField() async {
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: '${Resources.field}/$code',
        ), negativeResponse: {});
  }

  mapAllFields() async {
    fields = await getFields();
    Map mappedFields = {};

    for (int index = 0; index < fields.length;  index++) {
      mappedFields['${fields[index][JsonResponses.fieldOptionDescription]}'] = fields[index][JsonResponses.fieldOptionCode];
    }
    return mappedFields;
  }

  getOptions() async {
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: '${Resources.field}/$code/${Resources.option}',
        ), negativeResponse: []);
  }

  mapFieldsOptions() async {
    dynamic options = await getOptions();
    Map<String, String> mappedFields = {};
    for (int index = 0; index < options.length;  index++) {
      mappedFields['${options[index][JsonResponses.fieldOptionDescription]}'] = options[index][JsonResponses.fieldOptionCode].toString();
    }
    return mappedFields;
  }
}
