import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<String> get _localPath() async{
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get _localFile async{
  final path = _localPath;
  return File('$path/users.txt');
}

// Notice write operation returns a new file
Future<File> writeData(String data) async{
  final file = _localFile;
  return await file.writeAsString(data);
}

Future<String?> readData() {
  try{
    final file = _localFile;
    return await file.readAsString();
  } 
  catch(e){
    return null;
  }
}