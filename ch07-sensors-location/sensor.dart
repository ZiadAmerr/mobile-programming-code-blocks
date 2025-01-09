import 'package:sensors_plus/sensors_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SensorCalibration {
  double? accelerometerOffsetX;
  double? accelerometerOffsetY;
  double? accelerometerOffsetZ;

  // << CHECK IF CALIBRATED USING isCalibrated FLAG >>
  Future<bool> checkCalibrationStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Shared Preferences getBool returns bool? we want to return bool so we use ?? false to return false if it is null
    return prefs.getBool('isCalibrated') ?? false;
  }

  // Define a function that gets the mean of the readings and returns the offset
  double? getMeanOffset(List<double> readings) {
    return readings.reduce((a,b) => a + b) / readings.length;
  }

  // << CALIBRATE SENSOR >>
  Future<void> calibrateSensor() async {
    List<double> accelXReadings = [];
    List<double> accelYReadings = [];
    List<double> accelZReadings = [];

    accelerometerEvents.listen(
        (AccelerometerEvent event) {  
          accelXReadings.add(event.x);
          accelYReadings.add(event.y);
          accelZReadings.add(event.z);

          // Stop when collecting enough readings, in our case 100 readings
          if(accelXReadings.length > 100) {  
            accelerometerEvents.drain();
          }
          
          // Get mean offset for each axis from the collected list of readings
          accelerometerOffsetX = getMeanOffset(accelXReadings);
          accelerometerOffsetY = getMeanOffset(accelYReadings);
          accelerometerOffsetZ = getMeanOffset(accelZReadings);

          _saveCalibrationData(); // Will be implemented
        },
      onError: (error)=>print(error),
      cancelOnError: true
    );
  }

  // << SAVE CALIBRATION DATA >>
  Future<void> _saveCalibrationData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isCalibrated', true);
    prefs.setDouble('accelerometerOffsetX', accelerometerOffsetX!);
    prefs.setDouble('accelerometerOffsetY', accelerometerOffsetY!);
    prefs.setDouble('accelerometerOffsetZ', accelerometerOffsetZ!);
  }

  // << GET CALIBRATED ACCELEROMETER DATA >>
  Future<AccelerometerEvent> getCalibratedAccelerometerData() async {
    return accelerometerEvents.map((event) {  
      return AccelerometerEvent(
          event.x - accelerometerOffsetX!,
          event.y - accelerometerOffsetY!,
          event.z - accelerometerOffsetZ!,
          event.timestamp
      );
    }).first;
  }
}