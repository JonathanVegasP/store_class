import 'package:shared_preferences/shared_preferences.dart';

class FileManager {
  final String _file;

  FileManager(this._file);

  Future<SharedPreferences> _getFile() async {
    return await SharedPreferences.getInstance();
  }

  Future<String> readData() async {
    try {
      final file = await _getFile();
      if (file.containsKey(_file))
        return file.getString(_file);
      else
        return "";
    } catch (e) {
      print(e);
      return "";
    }
  }

  Future<bool> saveData(String data) async {
    try {
      final file = await _getFile();
      return await file.setString(_file, data);
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteFile() async {
    try {
      final file = await _getFile();
      return await file.remove(_file);
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteAllFiles() async {
    try {
      final file = await _getFile();
      return await file.clear();
    } catch (e) {
      print(e);
      return false;
    }
  }
}
