
import 'package:geolocator/geolocator.dart';

class Location {
   double latitude;

   double longitude;

  Future<void> getCurretLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      latitude = position.latitude ;
      longitude = position.longitude ;



      print(">>>>>>>>>>>>>>>>>>> lanti >>>> $latitude");
      print(">>>>>>>>>>>>>>>>>>> Longi >>>> $longitude");

    } catch (e) {
      print(e);
    }
  }
}
