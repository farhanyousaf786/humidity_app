import 'package:devicetemperature/devicetemperature.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:geolocator/geolocator.dart';

import 'location.dart';
import 'networking.dart';

const apiKey = 'dd6359b8920c1a71d2561dc152d6ad3f';



class AllFunctions {
   late double latitude;
  late double longitude;
  late String adress;
  late double insideTemperatureC;
  late double insideTemperatureF;
  late dynamic coordinates;

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurretLocation();

    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    latitude = position.latitude;
    longitude = position.longitude;

    //cityName

    coordinates = new Coordinates(latitude, longitude);

    var address =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);

    return address.first.addressLine;
  }

  Future<void> initDeviceTemperature() async {
    //Device Temp
    double temp;
    try {
      temp = await Devicetemperature.DeviceTemperature;
    } catch (e) {
      temp = 0.0;
    }

    insideTemperatureC = (temp - 7);

    insideTemperatureF = (((temp * 9 / 5) + 32) - 16);
  }
}
