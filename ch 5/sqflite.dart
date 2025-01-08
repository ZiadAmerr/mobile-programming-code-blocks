import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// We will build sqflite class for this object 
class User{
  final int id;
  final String name;
  final int age;

  // Constructor
  User({required this.id, required this.name, required this.age});

  // To map: function to transform the class into key-value pairs to be used by sqflite
  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'name':name,
      'age':age
    };
  }
}

/* Function that returns connection with the .db file */
Future<Database> openDatabaseConnection() async`{
  // Returns Database Object
  // OpenDatabase(path, onCreate, version)
  return OpenDatabase(
    // Path to .db file 
    join(await getDatabasesPath(), 'user_database.db'),

    // Function that will be called if the database does not exist to create a new one 
    onCreate: (db, version){
      return db.execute(
        // Normal SQL command
        "CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT, age INTEGER)",
      );
    },

    version: 1
  );
}

Future<void> insertUser(User user){
  Database database = openDatabaseConnection();
  // insert(table_name, data_as_json, conflictAlgorithm)
  await database.insert(
    'users',
    user.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

/*
Conflict Algorithms:
 - ConflictAlgorithm.abort = abort the operation and raise an error
 - ConflictAlgorithm.replace = replace the existing row with the new one
 - ConflictAlgorithm.ignore = ignore the new row if a conflict occurs 
 - ConflictAlgorithm.update = update the existing row with the new data 
*/