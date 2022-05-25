import 'package:mawa/services/keys.dart';
import 'package:mawa/services/network_requests.dart';

class Fields {
  static late List fields;
  getFields() async {
    dynamic response =await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodGet,
      resource: Resources.fields,
    );

    if (response.statusCode == 200) {
      return  await NetworkRequests.decodeJson(response);
    } else {
      return [];
    }
  }

  addField(String code, String desc) async {

    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPost,
        resource: Resources.fields,
        body: {
          JsonPayloads.fieldCode : code,
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
