part of 'package:mawa_package/mawa_package.dart';

class NetworkRequests {

  NetworkRequests({this.responseType}) {
    _getToken();
  }

  Future<void> _getToken() async {
    _key = preferences.then((SharedPreferences prefs) {
      return (prefs.getString(SharedPrefs.token) ?? '');
    });
  }

  String? responseType /* = responseJson*/;

  static const String methodGet = 'get';
  static const String methodPost = 'post';
  static const String methodPut = 'put';
  static const String methodDelete = 'delete';
  late String server;
  static String pot = '8181';
  late final String endpointURL;
  static String path = '/mawa-api/resources/';
  late http.Response feedback;
  late final Future<String> _key;
  static String token = '';
  static String tenantID = '';
  static String otp = '';
  static int statusCode = 100;
  static const String responseJson = 'json';
  static const String responseBlob = 'blob';
  static const String responseFormData = 'blob';
  dynamic responseCaught;

  static const int requestTime = 60;

  static decodeJson(data, {dynamic negativeResponse}) async {
    dynamic response = await data;
    if (response.statusCode == 200 || response.statusCode == 201) {
      try {
        return jsonDecode(response.body) ?? negativeResponse;
      } catch (e) {
        return negativeResponse;
      }
    } else {
      return negativeResponse;
    }
  }

  Map<String, String> headers({required String tokenKey, bool secured = true}) {



    Map<String, String> headers = {
      "X-TenantID": tenantID,
    };
    secured ? headers["Authorization"] = "Bearer $token" : null;

    responseType ??= responseJson;
    if (responseType == responseJson) {
      headers['Content-type'] = 'application/json; charset=UTF-8';
    }
    if (responseType == responseBlob) {
      headers['Content-type'] = 'application/json';
    }
    if (responseType == responseFormData) {
      headers['Content-type'] = 'multipart/form-data';
    }

    return headers;
  }

  String getTenant() {
    if (kIsWeb) {
      // running on the web!
      var base = Uri.base.origin;
      return base.split('//').last;
    } else {
      return "";
      // NOT running on the web! You can check for additional platforms here.
    }
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

  Future<dynamic> securedMawaAPI(
    String method, {
    required String resource,
    dynamic body,
    Map<String, dynamic>? queryParameters,
        bool secured = true,
  }) async {
    // token == null ? token = await _key: null;
    final SharedPreferences prefs = await preferences;

    server = await prefs.getString(SharedPrefs.server) ?? '';
    token = await prefs.getString(SharedPrefs.token) ?? '';

    String tenant = prefs.getString(SharedPrefs.tenantID) ?? '';
    if(tenant.isNotEmpty){
      tenantID = tenant;
    }
    else{
      if (kIsWeb) {
        var base = Uri.base.origin;
        tenantID = base.split('//').last;
      } else {
        tenantID = tenant;
      }
    }
    endpointURL = 'https://$server/';

    dynamic url;
    dynamic header = headers(
      tokenKey: token,
      secured: secured,
    );
    url = Uri.https(server, resource, queryParameters);
    if (kDebugMode) {
      print(method);
      print(url);
      print(header);
      print(body);
    }
      try {
        switch (method) {
          case methodGet:
            feedback = await http.get(
              url,
              headers: header,
            );
            break;
          case methodDelete:
            feedback = await http.delete(
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
            feedback = await http.put(url,
                // Uri.https(endpointURL, path + resource),
                headers: headers(tokenKey: token),
                body: jsonEncode(body));
            break;
        }

        statusCode = feedback.statusCode;
        switch (statusCode) {
          case 401:
            {
              Navigator.pushReplacementNamed(Tools.context, AuthenticateView.id);
            }
            break;
          default:
            {

            }
            break;
        }

        if (kDebugMode) {
          print('${feedback.statusCode}\n${feedback.body}');
        }
        return feedback;
      } on TimeoutException catch (e) {
        if (kDebugMode) {
          print(e);
        }
        Alerts.toastMessage(
            message: 'Request Timed Out. \nCheck Network Connection.',
            positive: false);
        responseCaught = http.Response('Request Timed Out', 491);
        return responseCaught;
      } on SocketException catch (e) {
        if (kDebugMode) {
          print(e);
        }
        Alerts.toastMessage(
            message: 'Encountered Network Problem',
            positive: false);
        responseCaught = http.Response('Encountered Network Problem', 492);
        return responseCaught;
      } on HandshakeException catch (e) {
        if (kDebugMode) {
          print(e);
        } Alerts.toastMessage(
            message: 'Request Terminated During Handshake',
            positive: false);
        responseCaught =
            http.Response('Could Not Establish Connection With Remote', 493);
        return responseCaught;
      }
      on CertificateException catch(e){
        if (kDebugMode) {
          print(e);
        }
        Alerts.toastMessage(
            message: 'Certificate Error',
            positive: false);
        responseCaught =
            http.Response('Certificate Error', 494);
        return responseCaught;
      }
      catch (e) {
        if (kDebugMode) {
          print(e);
        }
        Alerts.toastMessage(
            // context: Tools.context,
            message: 'Ran Into A Problem',
            positive: false);
        responseCaught = http.Response('Ran Into A Problem', 499);
        return responseCaught;
      }

  }

  Future unsecuredMawaAPI(
    String method, {
    required String resource,
    Map<String, String>? payload,
    Map<String, dynamic>? queryParameters,
    BuildContext? context,
  }) async {
    final SharedPreferences prefs = await preferences;
    server = await prefs.getString(SharedPrefs.server) ?? '';

    if (kIsWeb) {
      var base = Uri.base.origin;
      tenantID = base.split('//').last;
    } else {
      tenantID = await prefs.getString(SharedPrefs.tenantID) ?? '';
    }
    endpointURL = 'https://$server/';
    // endpointURL = server;//'api-$server.mawa.co.za:$pot';

    dynamic url;
    // url = Uri.parse(endpointURL + resource);
    url = Uri.https(server,resource,queryParameters);


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
            headers: this.headers(tokenKey: token, secured: false),
          );
          break;
        case methodDelete:
          feedback = await http.delete(
            url,
            // headers: headers,
            headers: this.headers(tokenKey: token, secured: false),
          );
          break;
        case methodPost:
          feedback = await http.post(url,
              headers: this.headers(tokenKey: token, secured: false),
              // headers: headers,
              body: jsonEncode(payload));
          break;
        case methodPut:
          feedback = await http.put(url,
              headers: this.headers(tokenKey: token, secured: false),
              // headers: headers,
              body: jsonEncode(payload));
          break;
      }
      statusCode = feedback.statusCode;


      // if (statusCode == 200) {
      //
      // }
      switch (NetworkRequests.statusCode) {
        case 200:
          {
            dynamic data;
            Tools.isTouchLocked = false;
            data = jsonDecode(feedback.body);
            if (resource == Resources.otp) {
              otp = await data;
            }
            if (resource == Resources.authenticate) {
              // User.username = await data[JsonResponses.username];
              token = await data[JsonResponses.token];
              Token.refreshToken = await data[JsonResponses.refreshToken] ?? '';
              preferences.then((SharedPreferences prefs) {
                return (prefs.setString(SharedPrefs.token, token));
              });
              preferences.then((SharedPreferences prefs) {
                return (prefs.setString(
                    SharedPrefs.refreshToken, Token.refreshToken));
              });
              preferences.then((SharedPreferences prefs) {
                return (prefs.setString(SharedPrefs.username, User.username));
              });
              //   /*// final String string = (prefs.getString(SharedPreferencesKeys.token) ?? '');
              //
              //  // _key =
              //      prefs.setString(SharedPreferencesKeys.token, string)
              // //      .then((bool success) {
              // //   return token;
              // // })
              // ;*/
              //   await User().getUserDetails(payload![JsonResponses.userID]!);
              //   // Navigator.pushReplacementNamed(context, direct!);
              //   postAuthenticate;
              User.loggedInUser = await User(User.username).get();
            }

          }
          break;
        case 401:
          {
            Tools.isTouchLocked = false;
            Alerts.toastMessage(
              message: 'Incorrect credentials',
              positive: false,
            );
          }
          break;
        case 404:
          {
            Tools.isTouchLocked = false;
            Alerts.toastMessage(
              message: 'Server Down',
              positive: false,
            );
          }
          break;
        case 0:
          {
            Tools.isTouchLocked = false;
            Alerts.toastMessage(
              message: 'Network Error',
              positive: false,
            );
          }
          break;
        case 1:
          {
            Tools.isTouchLocked = false;
            Alerts.toastMessage(
              message: 'Network Error',
              positive: false,
            );
          }
          break;
        default:
          {
            Tools.isTouchLocked = false;
            Alerts.toastMessage(
              message: 'Login failed',
              positive: false,
            );
          }
          break;
      }
      // print('yoghurt ' + token.toString());
      Tools.isTouchLocked = false;
      return feedback;
    } on TimeoutException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      Tools.isTouchLocked = false;
      // Navigator.maybePop(Tools.context);
      Alerts.toastMessage(
        message: 'Request Timed Out. \nCheck Network Connection.',
        positive: false,
      );
      responseCaught = http.Response('Request Timed Out', 491);
      // responseCaught.statusCode = 491;
      // responseCaught.reasonPhrase = 'Request Timed Out';
      return responseCaught;
    }
    on CertificateException catch(e){
      if (kDebugMode) {
        print(e);
      }
      Alerts.toastMessage(
          message: 'Certificate Error',
          positive: false);
      responseCaught =
          http.Response('Certificate Error', 494);
      return responseCaught;
    }
    on SocketException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      Tools.isTouchLocked = false;
      Alerts.toastMessage(
        message: 'Encountered Network Problem',
        positive: false,
      );
      responseCaught = http.Response('Encountered Network Problem', 492);
      // responseCaught.statusCode = 492;
      // responseCaught.reasonPhrase = 'Encountered Network Problem';
      return responseCaught;
    } on HandshakeException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      Tools.isTouchLocked = false;
      Alerts.toastMessage(
        message: 'Request Terminated During Handshake',
        positive: false,
      );
      responseCaught =
          http.Response('Could Not Establish Connection With Remote', 493);
      // responseCaught.statusCode = 493;
      // responseCaught.reasonPhrase =
      //     'Could Not Establish Connection With Remote';
      return responseCaught;
    }
    // on PresentationConnectionCloseEvent catch (e) {
    //   Tools.isTouchLocked = false;
    //   print(e.toString());
    //   Alerts.flushbar(
    //       context: Tools.context,
    //       message: 'Connection Lost During Request',
    //       positive: false);
    //        responseCaught = http.Response('Connection Lost During Request', 494);
    // }
    catch (e) {
      Tools.isTouchLocked = false;
      Alerts.toastMessage(
        // context: Tools.context,
        message: 'Something Went Wrong 2',
        positive: false,
      );
      responseCaught = http.Response('Ran Into A Problem', 499);
      // responseCaught.statusCode = 499;
      // responseCaught.reasonPhrase = 'Ran Into A Problem';
      return responseCaught;
    }
  }
}
