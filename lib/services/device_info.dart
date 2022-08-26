import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:io' as io;
import 'package:device_information/device_information.dart';
import 'package:flutter/widgets.dart';
import 'package:mawa_package/services.dart';
import 'package:mawa_package/services/tools.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:mawa_package/screens/alerts.dart';
import 'package:permission_handler/permission_handler.dart' as per;

///TO USE THIS CLASS SUCCESSFULLY ONE WOULD TO ADD "PHONE_READ_STATE [<uses-permission android:name="android.permission.READ_PHONE_STATE" />] PERMISSION ON ANDROID MANIFEST [android/app/src/main/AndroidManifest.xml].

class DeviceInfo{
  static String platformImei = 'Unknown';
  static String uniqueId = "Unknown";

  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};
  static late Map deviceData;
  static String terminal = 'Undefined';

  // static String  = ;
  static String platformVersion = 'platformVersion';
  static String imeiNo = 'imeiNo';
  static String modelName = 'modelName';
  static String manufacturer = 'manufacturer';
  static String apiLevel = 'apiLevel';
  static String deviceName = 'deviceName';
  static String productName = 'productName';
  static String cpuType = 'cpuType';
  static String hardware = 'hardware';


  static String versionSecurityPatch = 'version.securityPatch';
  static String versionSdkInt = 'version.sdkInt';
  static String versionRelease = 'version.release';
  static String versionPreviewSdkInt = 'version.previewSdkInt';
  static String versionIncremental = 'version.incremental';
  static String versionCodename = 'version.codename';
  static String versionBaseOS = 'version.baseOS';
  static String board = 'board';
  static String bootloader = 'bootloader';
  static String brand = 'brand';
  static String device = 'device';
  static String display = 'display';
  static String fingerprint = 'fingerprint';
  // static String hardware = 'hardware';
  static String host = 'host';
  static String id = 'id';
  // static String manufacturer = 'manufacturer';
  static String model = 'model';
  static String product = 'product';
  static String supported32BitAbis = 'supported32BitAbis';
  static String supported64BitAbis = 'supported64BitAbis';
  static String supportedAbis = 'supportedAbis';
  static String tags = 'tags';
  static String type = 'type';
  static String isPhysicalDevice = 'isPhysicalDevice';
  static String androidId = 'androidId';
  static String systemFeatures = 'systemFeatures';

  static String name = 'name';
  static String systemName = 'systemName';
  static String systemVersion = 'systemVersion';
  static String localizedModel = 'localizedModel';
  static String identifierForVendor = 'identifierForVendor';
  static String utsnameSysname = 'utsname.sysname';
  static String utsnameNodename = 'utsname.nodename';
  static String utsnameRelease = 'utsname.release';
  static String utsnameVersion = 'utsname.version';
  static String utsnameMachine = 'utsname.machine';

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    // final String imei = build.

    return <String, dynamic>{
      versionSecurityPatch: build.version.securityPatch,
      versionSdkInt: build.version.sdkInt,
      versionRelease: build.version.release,
      versionPreviewSdkInt: build.version.previewSdkInt,
      versionIncremental: build.version.incremental,
      versionCodename: build.version.codename,
      versionBaseOS: build.version.baseOS,
      board: build.board,
      bootloader: build.bootloader,
      brand: build.brand,
      device: build.device,
      display: build.display,
      fingerprint: build.fingerprint,
      hardware: build.hardware,
      host: build.host,
      id: build.id,
      manufacturer: build.manufacturer,
      model: build.model,
      product: build.product,
      supported32BitAbis: build.supported32BitAbis,
      supported64BitAbis: build.supported64BitAbis,
      supportedAbis: build.supportedAbis,
      tags: build.tags,
      type: build.type,
      isPhysicalDevice: build.isPhysicalDevice,
      // androidId: build.androidId,
      systemFeatures: build.systemFeatures,
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      name: data.name,
      systemName: data.systemName,
      systemVersion: data.systemVersion,
      model: data.model,
      localizedModel: data.localizedModel,
      identifierForVendor: data.identifierForVendor,
      isPhysicalDevice: data.isPhysicalDevice,
      utsnameSysname: data.utsname.sysname,
      utsnameNodename: data.utsname.nodename,
      utsnameRelease: data.utsname.release,
      utsnameVersion: data.utsname.version,
      utsnameMachine: data.utsname.machine,
    };
  }

  DeviceInfo(){
    // getDeviceInfo();
    // getImei();
    requestDevicePermission();
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
    Map info = {};
    try {
      info[platformVersion] = await DeviceInformation.platformVersion;
      info[imeiNo] = await DeviceInformation.deviceIMEINumber;
      info[modelName] = await DeviceInformation.deviceModel;
      info[manufacturer] = await DeviceInformation.deviceManufacturer;
      info[apiLevel] =  await DeviceInformation.apiLevel;
      info[deviceName] = await DeviceInformation.deviceName;
      info[productName] = await DeviceInformation.productName;
      info[cpuType] = await DeviceInformation.cpuName;
      info[hardware] = await DeviceInformation.hardware;

      terminal = await DeviceInformation.deviceModel;
      platformImei = await DeviceInformation.deviceIMEINumber;

    } /*on PlatformException {
      info = {};
      platformVersion = 'Failed to get platform version.';
    }*/
    catch(e){
      print('catch ' + e.toString());
    }
    // dynamic _info ; // = info.keys ;
    // print('keys ${info.keys}');
    // print('length ${_info.length}');
    // print('_info ${_info}');
    // print('rtt '+ _info.runtimeType.toString());
    // _info.addAll(info.keys);
    // for(int i = 0; i < _info.length; i++){
    //   deviceData[_info[i]] = info[_info[i]];
    // }
    print('terminal ' + terminal);
    print('info ' + info.toString());
    print('deviceData ' + deviceData.length.toString());

    deviceData.addAll(Map<String,dynamic>.from(info));

    for(int i = 0; i < deviceData.length; i++){
      print(deviceData.values.elementAt(i));
    }
    print('done!!!!');
    print('deviceData ' + deviceData.length.toString());
  }

  Future<void> getDeviceInfo () async {
    // Map<String, dynamic> deviceData = <String, dynamic>{};

    try {
      if (io.Platform.isAndroid) {
        // deviceData = await   deviceInfoPlugin.androidInfo;
        deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
        // terminal = deviceData['brand'].toString() + '.' + deviceData['model'].toString();
      }
      else if (io.Platform.isIOS) {
        // deviceData = await deviceInfoPlugin.iosInfo;
        deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
        // terminal = deviceData['name'].toString() + '.' + deviceData['model'].toString();
      }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }

    getImei();
    // if (!mounted) return;

    // setState(() {
    //   _deviceData = deviceData;
    // });
  }

  requestDevicePermission() async {

    print('Inside Permission method');

    final status = await Permission.phone.request();

    if (status == PermissionStatus.granted) {
      print('Permission granted front ');
      getDeviceInfo();
    } else if (status == PermissionStatus.denied) {
      print('Permission denied');

      Alerts().popup(Tools.context, title:'Permission Required',message:'Permission is required!'  );
      //await openAppSettings();
    } else if (status == PermissionStatus.permanentlyDenied) {
      print('Do not ask again');
      await openAppSettings();
    }
  }

}

