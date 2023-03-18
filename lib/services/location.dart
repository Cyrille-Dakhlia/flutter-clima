import 'package:geolocator/geolocator.dart';

class Location {
  double? latitude;
  double? longitude;

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.lowest);
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print(e);
    }
  }

  Future<void> getCurrentLocationCheckingPermissions() async {
    bool serviceEnabled;
    LocationPermission locationPermission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location service is disabled. Please activate it.');
    } else {
      locationPermission = await Geolocator.checkPermission();
      if (LocationPermission.unableToDetermine == locationPermission) {
        return Future.error(
            'Unable to determine if location permission is enabled.');
      } else if (LocationPermission.denied == locationPermission ||
          LocationPermission.deniedForever == locationPermission) {
        locationPermission = await Geolocator.requestPermission();
      }

      if (LocationPermission.whileInUse == locationPermission ||
          LocationPermission.always == locationPermission) {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.lowest);
        latitude = position.latitude;
        longitude = position.longitude;
      }
    }
  }
}
