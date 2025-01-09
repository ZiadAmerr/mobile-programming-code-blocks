# Notes from Lecture Noteds
## Sensors
To use sensors on iOS, add `NSMotionUsageDescription` in app's `Info.plist` file
```xml
<key>NSMotionUsageDescription</key>
<string>Barometer access is used to provide you with the current altitude.</string>
```

- `UserAccelerometerEvent` device acc in $m/s^2$, *excluding gravity*.
- `AccelerometerEvent` device acc, *including gravity*.
- `GyroscopeEvent` rotational movement
- `MagnetometerEvent` ambient magnetic field, for compass.
- `BarometerEvent` atmospheric pressure in hPa (not supported on web).

Some devices do not have all sensors, so implement `onError` callback.

---

**Sampling rates** vary in Android, due to varying devices, versions, and OS customizations.

```dart
magnetometerEvents(
  samplingPeriod: SensorInterval.normalInterval
).listen(
    (MagnetometerEvent event) {
        print(event);
    },
    onError: (error) {
        print(error);
    },
    cancelOnError: true
)
```

---

### Restrictions

#### **Web:**
- Only accelerometer and gyroscope are supported.
- Magneto and barometers are not supported.
- Sampling rates are not guaranteed.

#### **iOS:**
- Barometer's updates with `CMAltimeter` occur at fixed intervals and can't be controlled, **even if** explicitly stated.

---

### Calibration

Multiple vendors $\rightarrow$ readings vary $\rightarrow$ needs calibration

## Location
To get the current location data:

```dart
Location location = Location();
LocationData currLoc = await location.getLocation();
```

### Request Permission
#### Android
```xml
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>
```

#### iOS
```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>Location is used to provide you with the current location.</string>
```

#### In-app
```dart
PermissionStatus status = await location.requestPermission();

if (status == PermissionStatus.granted) {
    // permission granted
} else {
    // permission denied
}
```

---

### Geolocator
```dart
Position pos = await Geolocator().getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high
);
```

#### Request permissions
```dart
bool serviceEnabled = await Geolocator().isLocationServiceEnabled();
LocationPermission permission = await Geolocator().checkPermission();

// If location services are enabled, but permissions are not granted
if (serviceEnabled && permission == LocationPermission.denied) {
    permission = await Geolocator().requestPermission();
}

// Other cases...
```


#### Google Maps
1. Using `google_maps_flutter` plugin.
2. Get API Key, and add it to `AndroidManifest.xml` and `Info.plist`.
3. Create a `GoogleMap` widget.

```dart
GoogleMap(
    initialCameraPosition: CameraPosition(
        target: LatLng(37, -122),
        zoom: 14
    ),
    onMapCreated: (GoogleMapController controller) {
        // Init map settings here!
    }
)
```


# Notes from Lecture Slides

## Sensors

`GyroscopeEvent` has roll, yaw and pitch attrs.
`AccelerometerEvent` and `UserAccelerometerEvent` have x, y, z attrs.

AccelerometerEvent reports 0 during free fall.

Events are exposed through a `BroadcastStream` interface.

Every stream allows to specify sampling rate.

---

## Location
Permissions have combination of:
- Category (fore/background)
- Accuracy (fine/coarse $\rightarrow$ precise/approx, respectively)

Accuracies:
- lowest `PRIORITY_PASSIVE`
- low `PRIORITY_LOW_POWER`
- medium `PRIORITY_BALANCED_POWER_ACCURACY`
- high+ `PRIORITY_HIGH_ACCURACY`

### Geolocator
- Background mode on Android:
  - `enableBackgroundMode({bool enable})` API before accessing location.
  - Add permissions in `AndroidManifest.xml`.
```xml
<uses-permission android:name="android.permission.FOREGROUND_SERVICE"/>
<uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION"/>
```
---
- Background mode on iOS:
  - Add permissions in `Info.plist`.
```xml
<!-- Support, basic -->
<key>NSLocationWhenInUseUsageDescription</key>
<string>Location is used to provide you with the current location.</string>

<!-- if app uses APIs that accesses location all the time, even if app is not running -->
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>Location is used to provide you with the current location.</string>

<!-- In background -->
<key>UIBackgroundModes</key>
<array>
    <string>location</string>
</array>
```

