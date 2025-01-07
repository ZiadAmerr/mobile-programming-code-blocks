import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

Future<Position> getCurrentPositionGeolocator() async{
  bool isServiceEnabled = false;
  LocationPermission isPermissionGranted;

  // Checking is service enabled
  isServiceEnabled = await Geolocator.isLocationServiceEnabled();
  if(!isServiceEnabled){
    return Future.error('Location services are disabled');
  }

  // Checking for location denied permissions
  isPermissionGranted = await Geolocator.checkPermission();
  if(isPermissionGranted == LocationPermission.denied){
    // Handle permission issue -- it was mentioned that you could ask for permissions again
    while(isPermissionGranted == LocationPermission.denied){
      isPermissionGranted = await Geolocator.requestPermission();
    }
  }

  // Checking for location denied forever permission
  if(isPermissionGranted == LocationPermission.deniedForever){
    // Handle permission
    return Future.error('Location permissions is denied forever');
  }

  // Now returning the current position
  // return Geolocator.getCurrentPosition();
  // LocationAccuracy. => high - low - medium - best - bestForNavigation
  return Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
}

Future<LocationData> getCurrentLocation() async{
  Location location = Location();
  LocationData locationData;
  bool isServiceEnabled = false;
  PermissionStatus isPermissionGranted;

  // Checking for Services
  isServiceEnabled = await location.serviceEnabled();
  if(!isServiceEnabled){
    isServiceEnabled = await location.requestService();
    if(!isServiceEnabled){
      return Future.error('could not enable location service');
    }
  }

  // Checking for permissions
  isPermissionGranted = await location.hasPermission();
  if(isPermissionGranted == PermissionStatus.denied){
    isPermissionGranted = await location.requestPermission();
    if(isPermissionGranted != PermissionStatus.granted){
      return Future.error('could not get location permissions');
    }
  }

  locationData = await location.getLocation();
  return locationData;
}