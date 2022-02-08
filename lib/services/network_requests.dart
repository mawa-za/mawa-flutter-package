// ignore_for_file: avoid_print
part of mawa;


class NetworkRequests {
  // final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  NetworkRequests({this.responseType}) {_getToken();}

  Future<void> _getToken ()async {

    _key = preferences.then((SharedPreferences prefs) {
      return (prefs.getString(SharedPrefs.token) ?? '');
    });
    print('key' + _key.toString());
  }
  String? responseType/* = responseJson*/;
  static const String methodGet = 'get';
  static const String methodPost = 'post';
  static const String methodPut = 'put';
  late String server;
  static String pot = '8181';
  late final String endpointURL;
  static String path = '/mawa-api/resources/';
  late http.Response feedback;
  late final Future<String> _key;
  static String token = '';
  static String otp = '';
  static int statusCode = 100;
  static const String responseJson = 'json';
  static const String responseBlob = 'blob';
  static const String responseFormData = 'blob';

  static const int requestTime = 60;

  static decodeJson(data) async{
  dynamic response = await data;
    if (response.statusCode == 200) {
      try {
        return jsonDecode(response.body);
      }
      catch (e) {
        print(e.toString());
      }
    }
  }

   Map<String, String> headers({required String tokenKey,}) {
    Map<String, String> headers = {/*"Authorization": "Bearer $tokenKey"*/};
    headers["Authorization"] = "Bearer $tokenKey";

    responseType ??= responseJson;
    print('responseType $responseType');
    if (responseType == responseJson)  headers['Content-type'] = 'application/json; charset=UTF-8';
    if (responseType == responseBlob)  headers['Content-type'] = 'application/json';
    if (responseType == responseFormData)  headers['Content-type'] = 'multipart/form-data';

    return headers;
  }

  Map statusMessages = {
    200: 'OK',
    201: 'Created',
    202: 'Accepted',
    203: 'Non-Authoritative Information',
    204: 'No Content',
    205: 'Reset Content',
    206: 'Partial Content',
    207: 'Multi-Status (WebDAV)',
    208: 'Already Reported (WebDAV)',
    226: 'IM Used',
    300: 'Multiple Choices',
    301: 'Moved Permanently',
    302: 'Found',
    303: 'See Other',
    304: 'Not Modified',
    305: 'Use Proxy',
    306: '(Unused)',
    307: 'Temporary Redirect',
    308: 'Permanent Redirect (experimental)',
    400: 'Bad Request',
    401: 'Unauthorized',
    402: 'Payment Required',
    403: 'Forbidden',
    404: 'Not Found',
    405: 'Method Not Allowed',
    406: 'Not Acceptable',
    407: 'Proxy Authentication Required',
    408: 'Request Timeout',
    409: 'Conflict',
    410: 'Gone',
    411: 'Length Required',
    412: 'Precondition Failed',
    413: 'Request Entity Too Large',
    414: 'Request-URI Too Long',
    415: 'Unsupported Media Type',
    416: 'Requested Range Not Satisfiable',
    417: 'Expectation Failed',
    418: 'I\'m a teapot (RFC 2324)',
    420: 'Enhance Your Calm (Twitter)',
    422: 'Unprocessable Entity (WebDAV)',
    423: 'Locked (WebDAV)',
    424: 'Failed Dependency (WebDAV)',
    425: 'Reserved for WebDAV',
    426: 'Upgrade Required',
    428: 'Precondition Required',
    429: 'Too Many Requests',
    431: 'Request Header Fields Too Large',
    444: 'No Response (Nginx)',
    449: 'Retry With (Microsoft)',
    450: 'Blocked by Windows Parental Controls (Microsoft)',
    451: 'Unavailable For Legal Reasons',
    499: 'Client Closed Request (Nginx)',
    500: 'Internal Server Error',
    501: 'Not Implemented',
    502: 'Bad Gateway',
    503: 'Service Unavailable',
    504: 'Gateway Timeout',
    505: 'HTTP Version Not Supported',
    506: 'Variant Also Negotiates (Experimental)',
    507: 'Insufficient Storage (WebDAV)',
    508: 'Loop Detected (WebDAV)',
    509: 'Bandwidth Limit Exceeded (Apache)',
    510: 'Not Extended',
    511: 'Network Authentication Required',
    598: 'Network read timeout error',
    599: 'Network connect timeout error',
  };


  Future<dynamic> securedMawaAPI(String method,
      {required String resource,
        Map? body,
        Map<String, dynamic>? queryParameters,}) async  {
    // token == null ? token = await _key: null;
    final SharedPreferences prefs = await preferences;

    server = await prefs.getString(SharedPrefs.server) ?? '';
    token = await prefs.getString(SharedPrefs.token) ?? '';

    endpointURL =  'api-$server.mawa.co.za:$pot';

    dynamic url;
    dynamic header = headers(tokenKey: token,);
    // statusCode == null? statusCode= 100: null;
    // server == 'qas'
    //     ? url =  Uri.https(endpointURL, path + resource, queryParameters)
    //     : url = Uri.http(endpointURL, path + resource, queryParameters);
    url = Uri.https(endpointURL, path + resource, queryParameters);
    print('status code: $statusCode');
    if (statusCode != 401) {
      try {
        print('\n' + token.toString() + '\n');
        print(method);
        print(endpointURL);
        print(path);
        print(resource);
        print(body ?? queryParameters);
        print(header);
        switch (method) {
          case methodGet:
            feedback = await http.get(
              url,
              headers: header,
            );
            break;
          case methodPost:
            feedback = await http.post(
              // Uri.https(endpointURL, path + resource, queryParameters),
                url,
                headers: headers(tokenKey: token),
                body: jsonEncode(body));
            break;
          case methodPut:
            print('wow wow $token');
            feedback = await http.put(url,
                // Uri.https(endpointURL, path + resource),
                headers: headers(tokenKey: token),
                body: jsonEncode(body));
            break;
        }

        print(resource + feedback.body);
        print('\n' +
            feedback.runtimeType.toString() +
            feedback.contentLength.toString() +
            '\n');
        statusCode = feedback.statusCode;
        print('status code: $statusCode');
        switch (statusCode) {
          case 200:
            {
              // try {
              //   return jsonDecode(feedback.body);
              // } catch (e) {
              //   print(e.toString());
              // }
              print('Success');
              // return feedback;
            }
            break;
          case 401:
            {
              print('\npost\n');
              Navigator.pushReplacementNamed(Tools.context, Authenticate.id);
            }
            break;
          case 404:
            {
              Tools.isTouchLocked = false;
              // message(message: 'Server Is Down', textColor: Colors.redAccent, isLock: false);
              Alerts.flushbar(
                  context: Tools.context,
                  message: 'Server Down',
                  positive: false,
                  popContext: false);
            }
            break;
          case 417:
            {
              Alerts.flushbar(
                  context: Tools.context,
                  message: NetworkRequests()
                      .statusMessages[NetworkRequests.statusCode],
                  positive: false,
                  popContext: false);
            }
            break;
          case 405:
            {
              Tools.isTouchLocked = false;
              // message(message: 'Login failed', textColor: Colors.redAccent, isLock: false);
              Alerts.flushbar(
                  context: Tools.context,
                  message: 'Not Allowed',
                  positive: false);
            }
            break;
          case 500:
            {
              Tools.isTouchLocked = false;
              Alerts.flushbar(
                  context: Tools.context,
                  message: 'Server Error',
                  positive: false);
            }
            break;
          case 0:
            {
              Tools.isTouchLocked = false;
              Alerts.flushbar(
                  context: Tools.context,
                  message: 'Network Error',
                  positive: false,
                  popContext: false);
            }
            break;
          case 1:
            {
              Tools.isTouchLocked = false;
              Alerts.flushbar(
                  context: Tools.context,
                  message: 'Network Error',
                  positive: false,
                  popContext: false);
            }
            break;
          default:
            {
              Tools.isTouchLocked = false;
              Alerts.flushbar(
                  context: Tools.context,
                  message: 'Request Failed',
                  positive: false);
            }
            break;
        }

        // else if (statusCode >= 400 && statusCode < 600 && statusCode != 417) {}

      } on TimeoutException catch (e) {
        // Navigator.maybePop(Tools.context);
        Tools.isTouchLocked = false;
        print(e.toString());
        Alerts.flushbar(
            context: Tools.context,
            message: 'Request Timed Out. \nCheck Network Connection.',
            positive: false);
      } on SocketException catch (e) {
        Tools.isTouchLocked = false;
        print(e.toString());
        Alerts.flushbar(
            context: Tools.context,
            message: 'Encountered Network Problem',
            positive: false);
      } on HandshakeException catch (e) {
        Tools.isTouchLocked = false;
        print(e.toString());
        Alerts.flushbar(
            context: Tools.context,
            message: 'Request Terminated During Handshake',
            positive: false);
      }
      // on PresentationConnectionCloseEvent catch (e) {
      //   Tools.isTouchLocked = false;
      //   print(e.toString());
      //   Alerts.flushbar(
      //       context: Tools.context,
      //       message: 'Connection Lost During Request',
      //       positive: false);
      // }

      return feedback;

    }
    else {
      print('\npre\n');
      // Authorize(context: Tools.context).attempt();
      Navigator.pushReplacementNamed(Tools.context, Authenticate.id);
    }
  }


  Future unsecuredMawaAPI(String method,
      {required String resource,
        Map<String, String>? payload,
        Map<String, dynamic>? queryParameters,
        required BuildContext context, String? direct,
        VoidCallback? postAuthenticate,
      }) async {

    final SharedPreferences prefs = await preferences;

    server = await prefs.getString(SharedPrefs.server) ?? '';

    endpointURL =  'api-$server.mawa.co.za:$pot';

    dynamic url;
    server == 'qas'
        ? url =  Uri.https(endpointURL, path + resource,queryParameters)
        : url = Uri.https(endpointURL, path + resource, queryParameters);
    Map<String, String> headers = {
      "Content-type": "application/json; charset=UTF-8"
    }; //
    print('howl');

    print(endpointURL);
    print(NetworkRequests.path);
    print(resource);
    print(payload);
    print('\n');

    try {
      // final
      // http.Response response =
      // await http.post(
      //     url,
      //     headers: headers,
      //     body: jsonEncode(payload));

      switch (method) {
        case methodGet:
          feedback = await http.get(
            url,
            // headers: headers,
            headers: this.headers(tokenKey: token),

          );
          break;
        case methodPost:
          feedback = await http.post(
              url,
              headers: this.headers(tokenKey: token),
              // headers: headers,
              body: jsonEncode(payload));
          break;
        case methodPut:
          print('wow wow $token');
          feedback = await http.put(url,
              headers: this.headers(tokenKey: token),
              // headers: headers,
              body: jsonEncode(payload));
          break;
      }
      print('6854486');
      statusCode = feedback.statusCode;

      print('this ${feedback.statusCode}');
      print('this ${feedback.body}');

      // if (statusCode == 200) {
      //
      // }
      switch (NetworkRequests.statusCode) {
        case 200:
          {
            dynamic data;
            Tools.isTouchLocked = false;
            data = jsonDecode(feedback.body);
            if(resource == Resources.otp) {
              otp = await data.toString();
            }
            if(resource == Resources.authenticate) {
              token = await data[JsonResponses.token];

              preferences.then((SharedPreferences prefs) {
                return (prefs.setString(SharedPrefs.token, token));
              });
              preferences.then((SharedPreferences prefs) {
                return (prefs.setString(SharedPrefs.username, User.username));
              });
              /*// final String string = (prefs.getString(SharedPreferencesKeys.token) ?? '');

             // _key =
                 prefs.setString(SharedPreferencesKeys.token, string)
            //      .then((bool success) {
            //   return token;
            // })
            ;*/
              await User().getUserDetails(payload![JsonResponses.userID]!);
              // Navigator.pushReplacementNamed(context, direct!);
              postAuthenticate;
            }

            print('token oyjfjdbfjd\n' + token.toString());
          }
          break;
        case 401:
          {
            Tools.isTouchLocked = false;
            Alerts.flushbar(
                context: Tools.context,
                message: 'Incorrect login',
                positive: false,
                popContext: true);
          }
          break;
        case 404:
          {
            Tools.isTouchLocked = false;
            Alerts.flushbar(
                context: Tools.context,
                message: 'Server Down',
                positive: false,
                popContext: true);
          }
          break;
        case 0:
          {
            Tools.isTouchLocked = false;
            Alerts.flushbar(
                context: Tools.context,
                message: 'Network Error',
                positive: false,
                popContext: true);
          }
          break;
        case 1:
          {
            Tools.isTouchLocked = false;
            Alerts.flushbar(
                context: Tools.context,
                message: 'Network Error',
                positive: false,
                popContext: true);
          }
          break;
        default:
          {
            Tools.isTouchLocked = false;
            Alerts.flushbar(
              context: Tools.context,
              message: 'Login failed',
              positive: false,
              popContext: true,);
          }
          break;
      }
      // print('yoghurt ' + token.toString());
      Tools.isTouchLocked = false;
    } on TimeoutException catch (e) {
      Tools.isTouchLocked = false;
      print(e.toString());
      Alerts.flushbar(
        context: Tools.context,
        message: 'Request Timed Out. \nCheck Network Connection.',
        positive: false,
        popContext: true,);
    } on SocketException catch (e) {
      Tools.isTouchLocked = false;
      print(e.toString());
      Alerts.flushbar(
          context: Tools.context,
          message: 'Encountered Network Problem',
          positive: false);
    } on HandshakeException catch (e) {
      Tools.isTouchLocked = false;
      print(e.toString());
      Alerts.flushbar(
        context: Tools.context,
        message: 'Request Terminated During Handshake',
        positive: false,
        popContext: true,
      );
    }
  }
}