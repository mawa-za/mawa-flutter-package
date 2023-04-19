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

  addField({
    required String desc
  }) async {

    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPost,
        resource: Resources.fields,
        body: {
          JsonPayloads.fieldDescription : desc,
        });

    return await NetworkRequests.decodeJson(response);
  }

  getSingleField() async {
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: '${Resources.field}/$code',
        ), negativeResponse: {});
  }

  mapAllFields() async {
    fields = getFields();
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
}
