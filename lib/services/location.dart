part of mawa;

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
    address = '${position.latitude},${position.longitude}';
    // List address = await Geocoder.local.findAddressesFromCoordinates(
    //     new Coordinates(position.latitude, position.longitude));
    //
    // final coordinates = new Coordinates(position.latitude, position.longitude);
    // dynamic addresses =
    // await Geocoder.local.findAddressesFromCoordinates(coordinates);
    // var first = addresses.first;
    // print("${first.featureName} : ${first.addressLine}");
    // print(address.first.addressLine.toString());
    // locationInfo = await addresses;
    // Location.address = await locationInfo.first.addressLine;
  }
}