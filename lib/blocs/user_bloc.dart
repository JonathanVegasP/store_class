import 'dart:convert';

import 'package:rxdart/rxdart.dart' show BehaviorSubject;
import 'package:store/data/user_data.dart';
import 'package:store/storage/file_manager.dart';
import 'package:store/storage/files.dart';

class UserBloc {
  final _user = BehaviorSubject<UserData>();

  Future<bool> initialize() async {
    final user = await FileManager(UserFile).readData();
    try {
      if (user.isNotEmpty) {
        _user.add(UserData.fromJson(json.decode(user)));
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Stream<UserData> get outUser => _user.stream;

  Function(UserData) get inUser => _user.add;

  UserData get user => _user.value;

  void dispose() {
    _user.close();
  }
}
