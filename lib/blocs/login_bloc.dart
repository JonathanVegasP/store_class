import 'dart:convert' show json;

import 'package:flutter/material.dart' show FocusNode;
import 'package:rxdart/rxdart.dart';
import 'package:store/blocs/user_bloc.dart';
import 'package:store/data/product_data.dart';
import 'package:store/data/user_data.dart';
import 'package:store/database/database.dart';
import 'package:store/storage/file_manager.dart';
import 'package:store/storage/files.dart';
import 'package:store/validators/login_validators.dart';

enum LoginState { IDLE, LOADING }

class LoginBloc with LoginValidators {
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _state = BehaviorSubject<LoginState>.seeded(LoginState.IDLE);
  final _error = BehaviorSubject<String>();

  final passwordFN = FocusNode();

  Stream<String> get outEmail => _email.stream.transform(emailValidator);

  Stream<String> get outPassword =>
      _password.stream.transform(passwordValidator);

  Stream<LoginState> get outState => _state.stream;

  Stream<bool> get outValidate =>
      Observable.combineLatest([outEmail, outPassword], (_) => true);

  Function(String) get inEmail => _email.add;

  Function(String) get inPassword => _password.add;

  Stream<String> get outError => _error.stream;

  void validateFields() {
    if (_email.value == null) _email.add("");
    if (_password.value == null) _password.add("");
  }

  Future<bool> signIn(UserBloc bloc) async {
    _error.add("");
    _state.add(LoginState.LOADING);
    final map = await Database()
        .getDataByJson("users", {"email": _email.value.trim().toLowerCase()});
    if (map["users"] == null) {
      _error.add("Usuário não foi encontrado");
    } else if (map["users"][0]["email"] == null) {
      _error.add("Usuário não foi encontrado");
    } else if (map["users"][0]["password"] != _password.value) {
      _error.add("Senha incorreta");
    } else {
      bloc.inUser(UserData.fromJson(map["users"][0]));
      final products = await Database().getDataByTable("products");
      List list = products["products"] as List;
      list = list.map((product) => ProductData.fromJson(product)).toList();
      bloc.inProducts(list);
      FileManager(ProductsFile).saveData(json.encode(products["products"]));
      FileManager(UserFile).saveData(json.encode(map["users"][0]));
      _state.add(LoginState.IDLE);
      return true;
    }
    _state.add(LoginState.IDLE);
    return false;
  }

  void dispose() {
    _email.close();
    _password.close();
    _state.close();
    _error.close();
    passwordFN.dispose();
  }
}
