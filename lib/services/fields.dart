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

