import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(MyApp());
}

// Instantiating the main app
class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'http example',
      home: Scaffold(body: Center(child: UsersListView())),
    );
  }
}

/*
    A model class we created to hold HTTP data
 */
class User{
  int id;
  String name;
  String email;
  // Normal constructor
  User(this.id, this.name, this.email);

  // Factory contructor to create a user object from JSON record
  factory User.fromMap(Map<String, dynamic> map){
    return User(
        map['id'] as int,
        map['name'] as String,
        map['email'] as String
    );
  }
}

// Widget to be shown in the app
// Implementation may differ, we just want to use FutureBuilder, ListView, ListTile
class UsersListView extends StatefulWidget{
  const UsersListView({super.key});

  @override
  State<UsersListView> createState() => UserListViewState();
}

class UserListViewState extends State<UsersListView>{
  late Future<List<User>> users;

  Future<List<User>?> fetchUsers() async{
    // Instantiate a Dio object
    Dio dio = Dio();
    
    // Get request -- notice we DON'T parse the string into URI 
    // Use await becuase we wait till the server returns data
    Response response = await dio.get('https://jsonplaceholder.typicode.com/users');
    // Post request -- if you want to upload data to a server via a URL 
    // Response response = await dio.post('https://jsonplaceholder.typicode.com/users/', data: data);

    /*
    status code: 
      200+ = successful codes
      400+ = unsuccessful codes
      ...
     */
    if(response.statusCode == 200){
      // The returned data is a list of users, we want to convert them to a list of User class
      // We save the response data into a List of JSON, List<dynamic>
      // dynamic means any type of incoming data
      List<dynamic> jsonData = response.data;
      // 1. use map to map each element in the list and perform a function on it
      // 2. use User.fromMap to hold a User class instead of JSON 
      // 3. convert it to a list 
      return jsonData.map((user)=>User.fromMap(user)).toList();
    }
    else{
      Future.error('could not fetch data');
    }
    return null;
  }

  @override
  Widget build(BuildContext context){
    // You can make a global variable holding the users list but I am simplifying
    
    /*
    // Returning FutureBuilder
     FutureBuilder(
      future: The future variable for which we wait to be filled 
      builder: Function that builds the widget using the data 
        (BuildContext context: to hold the current position in the tree,
        snapshot: to hold the future value 
        )
    */
    return FutureBuilder(
        // 1st attribute
        future: fetchUsers(),
        // 2nd attribute
        builder: (context, snapshot){
          // Checking the snapshot data
          
          // Snapshot has data
          if(snapshot.hasData){
            // build ListView of data from the snapshot -> returns List<User>?
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(snapshot.data![index].name ),
                  subtitle: Text(snapshot.data![index].email ),
                  leading: Text(snapshot.data![index].id.toString()),
                );
              },
            );
          }
          // Snapshot contains an error
          else if(snapshot.hasError){
            return Text('Could not fetch users');
          }
          // Snapshot is still waiting for a result
          return CircularProgressIndicator();
        }
    );
  }
}