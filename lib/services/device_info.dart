part of mawa;

class DeviceInfo{

  static String platformImei = 'Unknown';
  static String uniqueId = "Unknown";

  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};
  static dynamic deviceData;
  static String terminal = 'Undefined';

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'androidId': build.androidId,
      'systemFeatures': build.systemFeatures,
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }

  DeviceInfo(){
    getImei();
    getDeviceInfo();
  }

  Future<void> getImei() async {
    String imeiPlatform;
    String? idUnique;
    // Platform messages may fail, so we use a try/catch PlatformException.

    // try {
    //   imeiPlatform =
    //   await ImeiPlugin.getImei(shouldShowRequestPermissionRationale: false);
    //   List<String> multiImei = await ImeiPlugin.getImeiMulti();
    //   print(multiImei);
    //   idUnique = await ImeiPlugin.getId();
    // } on PlatformException {
    //   imeiPlatform = 'Failed to get platform version.';
    // }
    //
    //   platformImei = imeiPlatform;
    //   uniqueId = idUnique!;
  }

  Future<void> getDeviceInfo () async {
    // Map<String, dynamic> deviceData = <String, dynamic>{};

    try {
      if (Platform.isAndroid) {
        // deviceData = await   deviceInfoPlugin.androidInfo;
        deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
        terminal = deviceData['brand'].toString() + '.' + deviceData['model'].toString();
      }
      else if (Platform.isIOS) {
        // deviceData = await deviceInfoPlugin.iosInfo;
        deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
        terminal = deviceData['name'].toString() + '.' + deviceData['model'].toString();
      }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }

    // if (!mounted) return;

    // setState(() {
    //   _deviceData = deviceData;
    // });
  }


}