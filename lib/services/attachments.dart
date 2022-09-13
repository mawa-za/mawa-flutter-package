import 'package:dio/dio.dart'/* as dio*/;
import 'package:http_parser/http_parser.dart' as parser;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
// import 'dart:html' as f show File;
import 'package:file_picker/file_picker.dart';

import 'package:path_provider/path_provider.dart';
import 'package:mawa_package/services/globals.dart';
import 'package:mawa_package/services/keys.dart';
import 'package:mawa_package/services/network_requests.dart';


class Attachments{
  dynamic attachment;
  late List attachments;

  getAttachments({required String docType, required String parentType, required String parentReference}) async {
    attachments = await NetworkRequests.decodeJson( await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodGet,
      resource: Resources.attachments,
      queryParameters: {
        QueryParameters.documentType:docType,
        QueryParameters.parentType:parentType,
        QueryParameters.parentReference:parentReference,
      },
    ) ?? []);
    return attachments;
  }

  void showDownloadProgress(received, total) {
    if (total != -1) {
      print((received / total * 100).toStringAsFixed(0) + "%");
    }
  }

  viewAttachment({required Map attachment}) async {

    var tempDir = await getTemporaryDirectory();
    String fullPath = tempDir.path + '/' + '${attachment[JsonResponses.fileName]}';
    print('full path $fullPath');

    Dio dio = Dio();
    final SharedPreferences prefs = await preferences;

    dynamic server = prefs.getString(SharedPrefs.server) ?? '';
    dynamic token = (prefs.getString(SharedPrefs.token) ?? '');

    dynamic endpointURL =  'api-$server.mawa.co.za:${NetworkRequests.pot}';
    dynamic url = 'https://' + endpointURL + NetworkRequests.path + Resources.attachments + '/' + attachment[JsonResponses.id];


    // dio.options.headers['content-Type'] = 'multipart/form-data';
    // dio.options.headers['content-Type'] = 'application/json';
    // dio.options.headers["authorization"] = "Bearer $token";


    print(url);
    try {
      dio.download(url, fullPath);
      Response response = await
      // dio.get(url,
          dio.download(url, fullPath,
        queryParameters: {
          QueryParameters.extension: attachment[JsonResponses.extension],
        },
        onReceiveProgress: showDownloadProgress,
        //Received data with List<int>
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            // validateStatus: (status) {
            //   return status! < 500;
            // },
          headers:  {
              'Content-type': 'multipart/form-data',
            // "Content-type": "application/json",
            'Authorization': 'Bearer $token'
          },
        ),
      );
      print('${response.headers}: ${response.statusMessage}');
      print(response.data);
      File file = File(fullPath);
      var raf = file.openSync(mode: FileMode.write);
      // response.data is List<int> type
      raf.writeFromSync(response.data);
      await raf.close();
    } catch (e) {
      print(e);
    }
    // attachment = await NetworkRequests().securedMawaAPI(
    //   NetworkRequests.methodGet,
    //   resource: Resources.attachments + '/' + id,
    //   queryParameters: {
    //     QueryParameters.extension: extension,
    //   }
    // );
    // return attachment;
  }

  ///Please note that this class is incomplete and therefore will not work accordingly or at all
  uploadAttachment(var file,{required String documentType, required String parentType, required String parentReference}) async {
    print('jj');
    // token == null ? token = await _key: null;
    final SharedPreferences prefs = await preferences;

    dynamic server = await prefs.getString(SharedPrefs.server) ?? '';
    dynamic token = await (prefs.getString(SharedPrefs.token) ?? '');
    print('server: $server');
    print('token: $token');

    Map map ={
      JsonPayloads.parentType: parentType,
      JsonPayloads.parentReference: parentReference,
      JsonPayloads.documentType: documentType,
    };
    print(map);
    Dio dio = Dio();
    dio.options.headers['content-Type'] = 'multipart/form-data';
    // dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers["authorization"] = "Bearer $token";
    // response = await dio.post(url, data: data);

    // print('name ${file.absolute}');
    // print('name ${file.path}');
    dynamic endpointURL =  'api-$server.mawa.co.za:${NetworkRequests.pot}';
    dynamic url = 'https://' + endpointURL + NetworkRequests.path + Resources.attachments;
    // statusCode == null? statusCode= 100: null;
    // server == 'qas'
    //     ? url =  Uri.https(endpointURL, path + resource, queryParameters)
    //     : url = Uri.http(endpointURL, path + resource, queryParameters);
    dynamic uri = Uri.https(endpointURL, NetworkRequests.path + Resources.attachments, /*queryParameters*/);
    var formData = FormData.fromMap({
      // 'file': UploadFileInfo( File(file.path), file.name),
      'file': await MultipartFile.fromFile(file.path, filename: file.name, contentType:  parser.MediaType.parse('multipart/form-data')),
      // 'file': await MultipartFile.fromFile(file.path, filename: file.name, contentType:  parser.MediaType.parse('multipart/form-data')),
      JsonPayloads.parentType: parentType,
      JsonPayloads.parentReference: parentReference,
      JsonPayloads.documentType: documentType,
      "f":"json"
      // 'files': [
      //   await MultipartFile.fromFile('./text1.txt', filename: 'text1.txt'),
      //   await MultipartFile.fromFile('./text2.txt', filename: 'text2.txt'),
      // ]
    });
    var response = await dio.postUri(uri, data: formData);
    print('${response.statusCode}: ${response.statusMessage}');
    print('${response.data}');
    // FormData formData = new FormData.from({
    //   "name": "wendux",
    //   "file1": new UploadFileInfo(new File("./upload.jpg"), "upload1.jpg")
    // });
    // response = await dio.post("/info", data: formData)

    /*
    var stream =

     http.ByteStream(Stream.castFrom(file));
    // get file length
    var length = await file.length(); //imageFile is your image file
    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Bearer " + NetworkRequests.token
    }; // ignore this headers if there is no authentication

    // string to uri
    var uri = Uri.https(NetworkRequests().endpointURL, NetworkRequests.path + Resources.attachments,);

    // create multipart request
    var request =  http.MultipartRequest("POST", uri);

    // multipart that takes file
    var multipartFileSign =  http.MultipartFile('profile_pic', stream, length,
        filename: path.basename(file.path));

    // add file to multipart
    request.files.add(multipartFileSign);

    //add headers
    request.headers.addAll(NetworkRequests.headers(tokenKey: NetworkRequests.token));

    //adding params
    request.fields[JsonPayloads.documentType] = documentType;
    request.fields[JsonPayloads.parentType] = parentType;
    request.fields[JsonPayloads.parentReference] = parentReference;

    // send
    var response = await request.send();

    print(response.statusCode);
    print(response.reasonPhrase);

    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);

    });
    */

    // return  await NetworkRequests().securedMawaAPI(
    //     NetworkRequests.methodPost,
    //     resource: Resources.attachments,
    //     body: {
    //       JsonPayloads.documentType: documentType,
    //       JsonPayloads.parentType: parentType,
    //       JsonPayloads.parentReference: parentReference,
    //     }
    // );

    return response;
  }

}

//part of mawa;
//
// class Attachments{
//   dynamic attachment;
//   late List attachments;
//
//   getAttachments({required String docType, required String parentType, required String parentReference}) async {
//     dynamic response = await NetworkRequests().securedMawaAPI(
//       NetworkRequests.methodGet,
//       resource: Resources.attachments,
//       queryParameters: {
//         QueryParameters.documentType:docType,
//         QueryParameters.parentType:parentType,
//         QueryParameters.parentReference:parentReference,
//       },
//     ) ?? [];
//     if(response.statusCode == 200){
//       try{
//         attachment =  jsonDecode(response);
//       }
//       catch(e){
//         print(e.toString());
//       }
//     }
//     return attachments;
//   }
//
//   void showDownloadProgress(received, total) {
//     if (total != -1) {
//       print((received / total * 100).toStringAsFixed(0) + "%");
//     }
//   }
//
//   viewAttachment({required Map attachment}) async {
//
//     var tempDir = await getTemporaryDirectory();
//     String fullPath = tempDir.path + '/' + '${attachment[JsonResponses.fileName]}';
//     print('full path $fullPath');
//
//     Dio dio = Dio();
//     final SharedPreferences prefs = await preferences;
//
//     dynamic server = prefs.getString(SharedPrefs.server) ?? '';
//     dynamic token = (prefs.getString(SharedPrefs.token) ?? '');
//
//     dynamic endpointURL =  'api-$server.mawa.co.za:${NetworkRequests.pot}';
//     dynamic url = 'https://' + endpointURL + NetworkRequests.path + Resources.attachments + '/' + attachment[JsonResponses.id];
//
//
//     // dio.options.headers['content-Type'] = 'multipart/form-data';
//     // dio.options.headers['content-Type'] = 'application/json';
//     // dio.options.headers["authorization"] = "Bearer $token";
//
//
//     print(url);
//     try {
//       dio.download(url, fullPath);
//       Response response = await
//       // dio.get(url,
//           dio.download(url, fullPath,
//         queryParameters: {
//           QueryParameters.extension: attachment[JsonResponses.extension],
//         },
//         onReceiveProgress: showDownloadProgress,
//         //Received data with List<int>
//         options: Options(
//             responseType: ResponseType.bytes,
//             followRedirects: false,
//             // validateStatus: (status) {
//             //   return status! < 500;
//             // },
//           headers:  {
//               'Content-type': 'multipart/form-data',
//             // "Content-type": "application/json",
//             'Authorization': 'Bearer $token'
//           },
//         ),
//       );
//       print('${response.headers}: ${response.statusMessage}');
//       print(response.data);
//       File file = File(fullPath);
//       var raf = file.openSync(mode: FileMode.write);
//       // response.data is List<int> type
//       raf.writeFromSync(response.data);
//       await raf.close();
//     } catch (e) {
//       print(e);
//     }
//     // attachment = await NetworkRequests().securedMawaAPI(
//     //   NetworkRequests.methodGet,
//     //   resource: Resources.attachments + '/' + id,
//     //   queryParameters: {
//     //     QueryParameters.extension: extension,
//     //   }
//     // );
//     // return attachment;
//   }
//
//   ///Please note that this class is incomplete and therefore will not work accordingly or at all
//   uploadAttachment( file,{required String documentType, required String parentType, required String parentReference}) async {
//     print('jj');
//     // token == null ? token = await _key: null;
//     final SharedPreferences prefs = await preferences;
//
//     dynamic server = await prefs.getString(SharedPrefs.server) ?? '';
//     dynamic token = await (prefs.getString(SharedPrefs.token) ?? '');
//     print('server: $server');
//     print('token: $token');
//
//     Map map ={
//       JsonPayloads.parentType: parentType,
//       JsonPayloads.parentReference: parentReference,
//       JsonPayloads.documentType: documentType,
//     };
//     print(map);
//     Dio dio = Dio();
//     dio.options.headers['content-Type'] = 'multipart/form-data';
//     // dio.options.headers['content-Type'] = 'application/json';
//     dio.options.headers["authorization"] = "Bearer $token";
//     // response = await dio.post(url, data: data);
//
//     dynamic endpointURL =  'api-$server.mawa.co.za:${NetworkRequests.pot}';
//     dynamic url = 'https://' + endpointURL + NetworkRequests.path + Resources.attachments;
//     // statusCode == null? statusCode= 100: null;
//     // server == 'qas'
//     //     ? url =  Uri.https(endpointURL, path + resource, queryParameters)
//     //     : url = Uri.http(endpointURL, path + resource, queryParameters);
//     dynamic uri = Uri.https(endpointURL, NetworkRequests.path + Resources.attachments, /*queryParameters*/);
//     var formData = FormData.fromMap({
//       'file': await MultipartFile.fromFile(file.path, filename: file.name, contentType:  parser.MediaType.parse('multipart/form-data')),
//       JsonPayloads.parentType: parentType,
//       JsonPayloads.parentReference: parentReference,
//       JsonPayloads.documentType: documentType,
//       "f":"json"
//       // 'files': [
//       //   await MultipartFile.fromFile('./text1.txt', filename: 'text1.txt'),
//       //   await MultipartFile.fromFile('./text2.txt', filename: 'text2.txt'),
//       // ]
//     });
//     var response = await dio.post(url, data: formData);
//     print('${response.statusCode}: ${response.statusMessage}');
//     print('${response.data}');
//     // FormData formData = new FormData.from({
//     //   "name": "wendux",
//     //   "file1": new UploadFileInfo(new File("./upload.jpg"), "upload1.jpg")
//     // });
//     // response = await dio.post("/info", data: formData)
//
//     /*
//     var stream =
//
//      http.ByteStream(Stream.castFrom(file));
//     // get file length
//     var length = await file.length(); //imageFile is your image file
//     Map<String, String> headers = {
//       "Accept": "application/json",
//       "Authorization": "Bearer " + NetworkRequests.token
//     }; // ignore this headers if there is no authentication
//
//     // string to uri
//     var uri = Uri.https(NetworkRequests().endpointURL, NetworkRequests.path + Resources.attachments,);
//
//     // create multipart request
//     var request =  http.MultipartRequest("POST", uri);
//
//     // multipart that takes file
//     var multipartFileSign =  http.MultipartFile('profile_pic', stream, length,
//         filename: path.basename(file.path));
//
//     // add file to multipart
//     request.files.add(multipartFileSign);
//
//     //add headers
//     request.headers.addAll(NetworkRequests.headers(tokenKey: NetworkRequests.token));
//
//     //adding params
//     request.fields[JsonPayloads.documentType] = documentType;
//     request.fields[JsonPayloads.parentType] = parentType;
//     request.fields[JsonPayloads.parentReference] = parentReference;
//
//     // send
//     var response = await request.send();
//
//     print(response.statusCode);
//     print(response.reasonPhrase);
//
//     // listen for response
//     response.stream.transform(utf8.decoder).listen((value) {
//       print(value);
//
//     });
//     */
//
//     // return  await NetworkRequests().securedMawaAPI(
//     //     NetworkRequests.methodPost,
//     //     resource: Resources.attachments,
//     //     body: {
//     //       JsonPayloads.documentType: documentType,
//     //       JsonPayloads.parentType: parentType,
//     //       JsonPayloads.parentReference: parentReference,
//     //     }
//     // );
//
//     return response;
//   }
//
// }