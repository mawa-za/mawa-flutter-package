import 'package:mawa_package/services.dart';
import 'dart:async';
import 'package:package_info_plus/package_info_plus.dart';

class ApkVersion {
  late PackageInfo packageInfo;
  late String appName;
  late String packageName;
  late String version;
  late String buildNumber;
  static List allVersions = [];

  static dynamic apkUsable;

  ApkVersion(){
    getApkInfo();
  }

  Future getApkInfo()async {
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


    apkUsable = await checkApkValidity();
  }

  getApkListInfo() async {

    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: Resources.versions);
    allVersions = await NetworkRequests.decodeJson(response, negativeResponse: []);
    return allVersions;


    // return await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet, resource: Resources.versions));
  }

  checkApkValidity(/*{String versionCode}*/) async {
    Map<String, dynamic>? query = {
      QueryParameters.versionApkVersionCode:version,
      QueryParameters.versionAppName:appName
    };
    dynamic response = await NetworkRequests.decodeJson( await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet, resource: Resources.versions, queryParameters: query));
    // if(response.statusCode == 200) {
    // print('response ${response.toString()}');
      return response[JsonResponses.versionAppUsable];
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


}