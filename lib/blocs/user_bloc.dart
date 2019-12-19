import 'dart:convert';

import 'package:rxdart/rxdart.dart' show BehaviorSubject;
import 'package:rxdart/rxdart.dart';
import 'package:store/data/product_data.dart';
import 'package:store/data/user_data.dart';
import 'package:store/database/database.dart';
import 'package:store/storage/file_manager.dart';
import 'package:store/storage/files.dart';

class UserBloc {
  final _user = BehaviorSubject<UserData>();
  final _products = BehaviorSubject<List<ProductData>>();

  Future<bool> initialize() async {
    final user = await FileManager(UserFile).readData();
    if (user.isNotEmpty) {
      _user.add(UserData.fromJson(json.decode(user)));
      final products = "";
      if (products != null && products != "") {
        List list = json.decode(products);
        print(list);
        list = list.map((product) => ProductData.fromJson(product)).toList();
        _products.add(list);
      }
      getLastData();
      return true;
    } else {
      return false;
    }
  }

  Future<void> getLastData() async {
    try {
      final user = await Database().getDataByJson("users", {
        "id": _user.value.id,
      });
      if (user["users"] != null) {
        _user.add(UserData.fromJson(user["users"][0]));
      }
      final map = await Database().getDataByTable("products");
      print(map);
      if (map["products"] != null) {
        final list = map["products"] as List;
        _products.add(list.map((map) {
          return ProductData.fromJson(map);
        }).toList());
      }
    } catch (e) {
      print(e);
    }
  }

  Stream<bool> get outUser =>
      CombineLatestStream([_products.stream, _user.stream], (_) => true);

  void inUser(UserData userData) {
    _user.add(userData);
    if (_products.value == null) _products.add([]);
  }

  Function(List<ProductData>) get inProducts => _products.add;

  UserData get user => _user.value;

  List<ProductData> get products => _products.value;

  void dispose() {
    _user.close();
    _products.close();
  }
}
