/*import 'dart:io';
import 'package:path_provider/path_provider.dart';
class HcodyStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationSupportDirectory();
    return directory.path;
  }
  Future<File> _localFile(String relativePath) async{
  final path= await _localPath;
  return  File('$path/$relativePath');
 }

 Future<String> read(String relativePath) async {
    try {
      final file = await _localFile(relativePath);
      final contents = await file.readAsString();
      // return int.parse(contents);
      return contents;
    } catch (e) {

      return 'NODATA';
    }
  }

  Future<File> write(String  data,String relativePath) async {
    final file = await _localFile(relativePath);
    return file.writeAsString(data);
  }
  void createDirectory(String  name) {
    final path=  _localPath;
    Directory("$path/$name").create();
  }

}*///TODO DELETE IT MOVE THIS FILE TO MYLIB
