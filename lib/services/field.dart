part of 'package:mawa_package/mawa_package.dart';

class Field {
  final String code;
  Field(this.code) {
    resource = '${Resources.field}/$code';
  }
  late final String resource;

  static getAll() async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: Resources.field,
      ),
      negativeResponse: [],
    );
  }

  static create({
    required String desc,
    String? code,
    String? validFrom,
    String? validTo,
  }) async {
    desc = Strings.description(desc);
    validFrom ??= DateFormat(
                'yyyy-MM-dd',
              ).format(DateTime.now());
    validTo ??= '9999-12-31';
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPost,
      resource: Resources.field,
      body: {
        JsonPayloads.fieldDescription: desc,
        JsonPayloads.code: code ??
            desc
                .trim()
                .replaceAll(
              ' ',
              '-',
            )
                .toUpperCase(),
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
      negativeResponse: {},
    );
  }

  static mapAllFields() async {
    dynamic fields = await getAll();
    Map mappedFields = {};

    for (int index = 0; index < fields.length; index++) {
      mappedFields['${fields[index][JsonResponses.fieldOptionDescription]}'] =
      fields[index][JsonResponses.fieldOptionCode];
    }
    return mappedFields;
  }

  static getAllOptions() async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: '${Resources.field}/${Resources.option}',
      ),
      negativeResponse: [],
    );

  }

  getOptions() async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: '$resource/${Resources.option}',
      ),
      negativeResponse: [],
    );
  }

  Future<Map<String, String>> mapOptions() async {
    dynamic options = await getOptions();
    Map<String, String> mappedFields = {};
    for (int index = 0; index < options.length; index++) {
      mappedFields['${options[index][JsonResponses.fieldOptionDescription]}'] =
      options[index][JsonResponses.fieldOptionCode];
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
    String? code,
    required String validFrom,
    required String validTo,
  }) async {
    description = Strings.description(description);
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPost,
      resource: '$resource/${Resources.option}',
      body: {
        JsonPayloads.field: this.code,
        JsonPayloads.code: code ??
            description
                .trim()
                .replaceAll(
              ' ',
              '-',
            )
                .toUpperCase(),
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
