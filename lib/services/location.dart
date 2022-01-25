part of mawa;

///TO USE THIS CLASS ONE MUST:
///   Add the following to your "gradle.properties" file:
///     android.useAndroidX=true
///     android.enableJetifier=true
///   Make sure you set the compileSdkVersion in your "android/app/build.gradle" file to 30:
///     android {
///     compileSdkVersion 30
///       ...
///     }

class Location {
  static String address = '';
  static dynamic locationInfo;

  Location(){
    decodeGeolocation();
  }

  getGeolocation() async {
    return await Geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
  }

  decodeGeolocation() async {
    Position position = await getGeolocation();
    print(position);
    locationInfo = '${position.latitude},${position.longitude}';
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude,position.longitude);
    print(placemarks.toString());
    address = placemarks.first.toString();
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
}