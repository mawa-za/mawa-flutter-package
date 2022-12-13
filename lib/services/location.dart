part of 'package:mawa_package/mawa_package.dart';


///TO USE THIS CLASS ONE MUST:
///   Add the following to your "gradle.properties" file:
///     android.useAndroidX=true
///     android.enableJetifier=true
///   Make sure you set the compileSdkVersion in your "android/app/build.gradle" file to 30:
///     android {
///     compileSdkVersion 30
///       ...
///     }

enum ServiceStatus {
  /// Indicates that the location service on the native platform is enabled.
  disabled,

  /// Indicates that the location service on the native platform is enabled.
  enabled,
}

class Location {
  static String address = '';
  static dynamic locationInfo;

  Location(){
    // decodeGeolocation();
    requestLocationPermission();
  }

  getGeolocation() async {
    return await Geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
  }

  decodeGeolocation() async {
    Position position = await getGeolocation();
    locationInfo = '${position.latitude},${position.longitude}';
    List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude, position.longitude);
    address = '${placemarks.first.thoroughfare}, ${placemarks.first
        .subLocality}, ${placemarks.first.locality}, ${placemarks.first
        .subAdministrativeArea}, ${placemarks.first
        .administrativeArea}, ${placemarks.first.country}, ${placemarks.first
        .postalCode}';
    //   // List address = await Geocoder.local.findAddressesFromCoordinates(
    //   //     new Coordinates(position.latitude, position.longitude));
    //   //
    //   // final coordinates = new Coordinates(position.latitude, position.longitude);
    //   // dynamic addresses =
    //   // await Geocoder.local.findAddressesFromCoordinates(coordinates);
    //   // var first = addresses.first;
    //   // print("${first.featureName} : ${first.addressLine}");
    //   // print(address.first.addressLine.toString());
    //   // locationInfo = await addresses;
    //   // Location.address = await locationInfo.first.addressLine;
  }

  requestLocationPermission() async {

    final serviceStatusLocation = await Permission.locationAlways.isGranted;


    bool isLocation = serviceStatusLocation == ServiceStatus.enabled;

    final status = await Permission.locationAlways.request();

    if (status == PermissionStatus.granted) {
      decodeGeolocation();
    } else if (status == PermissionStatus.denied) {
      SystemNavigator.pop();
    } else if (status == PermissionStatus.permanentlyDenied) {
      Alerts().openPop(Tools.context, message: 'Please grant the location permission manually!',
          title: 'Please grant the location permission manually');
    }
  }


}