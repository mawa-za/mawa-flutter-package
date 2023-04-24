part of 'package:mawa_package/mawa_package.dart';

class Versions {
  late PackageInfo packageInfo;
  late String appName;
  late String packageName;
  late String version;
  late String buildNumber;
  static List allVersions = [];

  static dynamic apkUsable;

  Versions(){
    getAppInfo();
  }

  Future getAppInfo()async {
    packageInfo = await PackageInfo.fromPlatform();

    appName = packageInfo.appName;
    packageName = packageInfo.packageName;
    version = packageInfo.version;
    buildNumber = packageInfo.buildNumber;


    // PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
    //   appName = packageInfo.appName;
    //   packageName = packageInfo.packageName;
    //   version = packageInfo.version;
    //   buildNumber = packageInfo.buildNumber;
    // });


    apkUsable = await checkValidity();
  }

  getAppVersion() async {

    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: Resources.versions);
    allVersions = await NetworkRequests.decodeJson(response, negativeResponse: []);
    return allVersions;


    // return await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet, resource: Resources.versions));
  }

  checkValidity(/*{String versionCode}*/) async {
    Map<String, dynamic>? query = {
      QueryParameters.versionApkVersionCode:version,
      QueryParameters.versionAppName:appName
    };
    dynamic response = await NetworkRequests.decodeJson( await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet, resource: Resources.versions, queryParameters: query));
    // if(response.statusCode == 200) {
    // print('response ${response.toString()}');
      return response[JsonResponses.appUsable];
    // }
    // else {
    //   return null;
    // }
  }

  getSingleVersion() async {
    Map<String, dynamic>? query = {
      QueryParameters.versionApkVersionCode:version,
    };

    dynamic response = await NetworkRequests.decodeJson( await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet, resource: Resources.versions, queryParameters: query));
    print('YYYYYYYYYYY');
    print('$response');

  }

  editVersionUsability({
    String? appUsability,
    String? appName,
    String? versionNumber,
  }) async {
    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPut,
        resource: Resources.versions,
     body: {
          QueryParameters.versionAppUsable : appUsability,
       QueryParameters.versionAppName : appName,
       QueryParameters.versionApkVersionCode : versionNumber
     }
    );
    return await NetworkRequests.decodeJson(response, negativeResponse: false);
  }

  addVersion({
  required String versionNumber,
  required String appName,
  required String appUsability
  }) async{
    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPost,
      resource: Resources.versions,
      body: {
        JsonPayloads.versionNumber : versionNumber,
        JsonPayloads.appName : appName,
        JsonPayloads.appUsable : appUsability,
      }
    );
  }

//   versionSearch({
//     String? versionNumber,
//     String? appName
// })async{
//     List versions = await NetworkRequests.decodeJson(
//       await NetworkRequests().securedMawaAPI(
//           NetworkRequests.methodGet,
//           resource: Resources.versions,
//           queryParameters: {
//             QueryParameters.versionApkVersionCode: versionNumber
//           })
//     )
//   }

  /// new backend
  static getAllVersions() async {
    return await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
        resource: '${Resources.application}/${Resources.versions}'),
      negativeResponse: [],
    );
  }
}