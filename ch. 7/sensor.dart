import 'package:sensors_plus/sensors_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SensorCalibration{
  double? accelerometerOffsetX;
  double? accelerometerOffsetY;
  double? accelerometerOffsetZ;

  Future<bool> checkCalibrationStatus() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Shared Preferences getBool returns bool? we want to return bool so we use ?? false to return false if it is null
    return prefs.getBool('isCalibrated') ?? false;
  }

  Future<void> calibrateSensor() async{
    List<double> accelXReadings = [];
    List<double> accelYReadings = [];
    List<double> accelZReadings = [];

    accelerometerEvents.listen(
        (AccelerometerEvent event){
          accelXReadings.add(event.x);
          accelYReadings.add(event.y);
          accelZReadings.add(event.z);
          // Stop when collecting enough readings, in our case 100 readings
          if(accelXReadings.length > 100){
            accelerometerEvents.drain();
          }
          accelerometerOffsetX = accelXReadings.reduce((a,b) => a + b) / accelXReadings.length;
          accelerometerOffsetY = accelYReadings.reduce((a,b) => a + b) / accelYReadings.length;
          accelerometerOffsetZ = accelZReadings.reduce((a,b) => a + b) / accelZReadings.length;

          _saveCalibrationData(); // Will be implemented
        },
      onError: (error)=>print(error),
      cancelOnError: true
    );
  }

  Future<void> _saveCalibrationData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isCalibrated', true);
    prefs.setDouble('accelerometerOffsetX', accelerometerOffsetX!);
    prefs.setDouble('accelerometerOffsetY', accelerometerOffsetY!);
    prefs.setDouble('accelerometerOffsetZ', accelerometerOffsetZ!);
  }

  Future<AccelerometerEvent> getCalibratedAccelerometerData() async{
    return accelerometerEvents.map((event){
      return AccelerometerEvent(
          event.x - accelerometerOffsetX!,
          event.y - accelerometerOffsetY!,
          event.z - accelerometerOffsetZ!,
          event.timestamp
      );
    }).first;
  }
}