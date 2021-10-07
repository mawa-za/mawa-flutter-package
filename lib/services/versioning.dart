part of mawa;

class ApkVersion {
  late PackageInfo packageInfo;
  late String appName;
  late String packageName;
  late String version;
  late String buildNumber;

  static dynamic apkUsable;

  ApkVersion(){
    getApkInfo();
  }

  getApkInfo()async {
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

    print(appName + ' ' + packageName + ' ' + version + ' ' + buildNumber);

    apkUsable = await checkApkValidity();
  }

  getApkListInfo() async {
    return NetworkRequests().securedMawaAPI(NetworkRequests.methodGet, resource: Resources.versions);
  }

  checkApkValidity(/*{String versionCode}*/) async {
    Map<String, dynamic>? query = {
      QueryParameters.versionApkVersionCode:version,
      QueryParameters.versionAppName:appName
    };
    dynamic response = await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet, resource: Resources.versions, queryParameters: query);
    print(response ?? 'nothing');
    if(response != null) {
      return response[JsonResponseKeys.versionAppUsable];
    }
    else {
      return null;
    }
  }


}