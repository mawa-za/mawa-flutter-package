part of mawa;

class Attachments{
  dynamic attachment;
  late List attachments;

  getAttachments({required String docType, required String parentType, required String parentReference}) async {
    attachments = await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodGet,
      resource: Resources.attachments,
      queryParameters: {
        QueryParameters.documentType:docType,
        QueryParameters.parentType:parentType,
        QueryParameters.parentReference:parentReference,
      },
    ) ?? [];
    return attachments;
  }

  viewAttachment({required String id, required String extension}) async {
    attachment = await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodGet,
      resource: Resources.attachments + '/' + id,
      queryParameters: {
        QueryParameters.extension: extension,
      }
    );
    return attachment;
  }

  ///Please note that this class is incomplete and therefore will not work accordingly or at all
  uploadAttachment( file,{required String documentType, required String parentType, required String parentReference}) async {
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

    dynamic endpointURL =  'api-$server.mawa.co.za:${NetworkRequests.pot}';
    dynamic url = 'https://' + endpointURL + NetworkRequests.path + Resources.attachments;
    // statusCode == null? statusCode= 100: null;
    // server == 'qas'
    //     ? url =  Uri.https(endpointURL, path + resource, queryParameters)
    //     : url = Uri.http(endpointURL, path + resource, queryParameters);
    dynamic uri = Uri.https(endpointURL, NetworkRequests.path + Resources.attachments, /*queryParameters*/);
    var formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path, filename: file.name, contentType:  parser.MediaType.parse('multipart/form-data')),
      JsonPayloads.parentType: parentType,
      JsonPayloads.parentReference: parentReference,
      JsonPayloads.documentType: documentType,
      "f":"json"
      // 'files': [
      //   await MultipartFile.fromFile('./text1.txt', filename: 'text1.txt'),
      //   await MultipartFile.fromFile('./text2.txt', filename: 'text2.txt'),
      // ]
    });
    var response = await dio.post(url, data: formData);
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