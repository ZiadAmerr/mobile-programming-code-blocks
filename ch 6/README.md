# Firebase Authentication

FirebaseAuth provides many methods and utilities for enabling you to integrate secure authentication into your project and subscribe to the user’s authentication state.

## Tracking Authentication State

```dart
// You can use any of these methods
// FirebaseAuth.instance.authStateChanges().listen(
// FirebaseAuth.instance.idTokenChanges().listen(
FirebaseAuth.instance.userChanges().listen(
  (User? user) {
    if (user == null) {
      print('user is currently signed out');
    } else {
      print('user is signed in');
    }
  }
);
```

### authStateChanges()

- Right after the listener has been registered
- When the user is signed in
- When the user is signed out

### idTokenChanges()

- Right after the listener has been registered
- When the user is signed in
- When the user is signed out
- When the user’s token changes

### userChanges()

- Right after the listener has been registered
- When the user is signed in
- When the user is signed out
- `reload()`, `relink()`, `updateEmail()`, `updatePassword()`, `updatePhoneNumber()`, `updateProfile()`

## Persisting Authentication State

### Mobile Platforms

- This behavior is not configurable.
- The user authentication state persists between app restarts.
- The user can clear the app's cached data using the device settings, which will wipe any existing state being stored.

### Web

- The user’s authentication state is stored in IndexedDB.
- Persistence can be changed to be stored in the local storage using `Persistence.LOCAL`.

```dart
// Initialize persistence for Firebase Auth 
final auth = FirebaseAuth.instanceFor(
  app: Firebase.app(),
  persistence: Persistence.NONE
);

// Change persistence later in code
await auth.setPersistence(Persistence.LOCAL);
```

---

# Real-time Database vs. Cloud Firestore

## Firebase Firestore

- Enterprise-grade JSON-compatible **document** database.
- Suitable for applications with rich data models requiring queryability, scalability, and high availability.

### Writing Data

- **Set Data:** Overwrites the document.
- **Add Data:** Adds a new document with an auto-generated ID.

#### Example:

```dart
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;

// Set data (overwrite)
await firestore.collection('users').doc('userId123').set({
  'name': 'John Doe',
  'age': 25,
});

// Add data (auto-generated ID)
await firestore.collection('users').add({
  'name': 'Jane Doe',
  'age': 30,
});
```

### Reading Data

- **Get a Single Document**
- **Get All Documents in a Collection**
- **Stream Data for Real-time Updates**

#### Example:

```dart
// Get a single document
DocumentSnapshot doc = await firestore.collection('users').doc('userId123').get();
print(doc.data());

// Get all documents in a collection
QuerySnapshot querySnapshot = await firestore.collection('users').get();
querySnapshot.docs.forEach((doc) {
  print(doc.data());
});

// Stream real-time updates
firestore.collection('users').snapshots().listen((querySnapshot) {
  querySnapshot.docs.forEach((doc) {
    print(doc.data());
  });
});
```

### Updating Data

- Updates specific fields without overwriting the document.

#### Example:

```dart
await firestore.collection('users').doc('userId123').update({
  'age': 26, // Updates only the age field
});
```

---

## Firebase Realtime Database

- Firebase **JSON** database.
- Suitable for applications with simple data models requiring simple lookups and low-latency synchronizations.
- Allows secure access to the database from client-side code.
- Data persists locally.
- Synchronizes the local data with remote updates that occurred while the user was offline, merging conflicts automatically.

### Writing Data

- **Set Data:** Replaces the data at the specified location.
- **Push Data:** Adds a new child with a unique key.

#### Example:

```dart
import 'package:firebase_database/firebase_database.dart';

final FirebaseDatabase database = FirebaseDatabase.instance;

// Set data (overwrite)
await database.ref('users/userId123').set({
  'name': 'John Doe',
  'age': 25,
});

// Push data (auto-generated key)
await database.ref('users').push().set({
  'name': 'Jane Doe',
  'age': 30,
});
```

### Reading Data

- **Get Data Once**
- **Stream Data for Real-time Updates**

#### Example:

```dart
// Get data once
DatabaseReference ref = database.ref('users/userId123');
DatabaseEvent event = await ref.once();
print(event.snapshot.value);

// Stream real-time updates
database.ref('users').onValue.listen(
  (DatabaseEvent event) {
    print(event.snapshot.value);
  }
);
```

### Updating Data

- Updates specific fields without replacing the whole node.

#### Example:

```dart
await database.ref('users/userId123').update({
  'age': 26, // Updates only the age field
});
```

---

### Key Differences

- Firestore is better for complex, structured, and scalable data.
- Realtime Database is optimized for low-latency and simple data structures.

---

# Firebase Security

### Rule Types

- `.read`: Specifies if and when users are allowed to read.
- `.write`: Specifies if and when users are allowed to write.
- `.validate`: Enforces the format, structure, and data type of a value. Validation rules do not cascade.
- `.indexOn`: Specifies a child property to index for efficient querying and ordering.

#### Authorization

```json
{
  "rules": {
    "foo": {            
      ".read": true,     // Users can read this path
      ".write": false    // Users cannot write in this path
    }
  }
}
```

```json
{
  "rules": {
    "users": {
      "$uid": {   
        ".read": true,   // Can read all user records  
        ".write": "$uid === auth.uid"  // Can only write if user is authenticated
      }
    }
  }
}
```

#### Validation

```json
{
  "rules": {
    "foo": {
      ".validate": "newData.isString() && newData.val().length < 100"
    }
  }
}
```

#### Indexing

```json
{
  "rules": {
    "foo": {
      ".indexOn": ["length", "height"]
    }
  }
}
```

---

# Firebase Cloud Messaging (FCM)

### Implementation Steps

1. Add FCM to your Flutter application.
2. Request permissions to receive push notifications.
3. Obtain FCM token that uniquely identifies the user’s device.
4. Use FCM server API to send a notification.
5. Implement logic in Flutter that handles incoming notifications.

#### Example:

```dart
// pubspec Dependency: firebase_messaging

FirebaseMessaging.onMessage.listen(
  (RemoteMessage message) {
    print('Message received: ${message.notification?.title}');
  }
);

FirebaseMessaging.onMessageOpenedApp.listen(
  (RemoteMessage message) {
    Navigator.pushNamed(context, '/cart');
  }
);