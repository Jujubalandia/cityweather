import 'package:geolocator/geolocator.dart';

class Location {
  double latitude;
  double longitude;

  Location({this.latitude, this.longitude});

  Future<void> getCurrentLocation() async {
    try {
      Geolocator geolocator = Geolocator();
      if (!await geolocator.isLocationServiceEnabled()) {
        print('Location service unavailable!');
        return;
      }
      GeolocationStatus status =
          await geolocator.checkGeolocationPermissionStatus();
      if (status != GeolocationStatus.granted) {
        print('NO permission granted for location services');
        return;
      }

      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print(e);
    }
  }
}
