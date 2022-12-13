part of 'package:mawa_package/mawa_package.dart';

class Fields {
  static List fields = [];
  getFields() async {
    dynamic response =await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodGet,
      resource: Resources.fields,
    );

      fields = await NetworkRequests.decodeJson(response);
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

    // var url = Uri.https('api-dev.mawa.co.za:8181', '/mawa-api/resources/fields');
    // var data = {
    //   "code": code,
    //   "description": description,
    // };
    //
    // final response = await http.post(url, headers: {
    //   'Content-Type': 'application/json',
    //   'Accept': 'application/json',
    //   'Authorization': 'Bearer ${NetworkRequests.token}',
    // }, body: jsonEncode(data));
    //
    // var jsonResponse;
    //
    // if(response.statusCode == 200 || response.statusCode == 201) {
    //   print(response.statusCode);
    //   jsonResponse = jsonDecode(response.body);
    //   print(jsonResponse);
    //   print("FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF");
    // }

  }

}

// part of mawa;
//
// class Fields {
//   static late List fields;
//   getFields() async {
//     dynamic response = await NetworkRequests().securedMawaAPI(
//       NetworkRequests.methodGet,
//       resource: Resources.fields,
//     );
//
//     if (NetworkRequests.statusCode == 200) {
//       return response;
//     } else {
//       return [];
//     }
//   }
// }
//
