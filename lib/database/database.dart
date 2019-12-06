import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';

class Database {
  final String _key = "c33367701511b4f6020ec61ded352059";
  final String _id = "com.vollup.store";
  final String _url = "https://flutter-store.herokuapp.com/database";

  static final Database _instance = Database._internal();

  Database._internal();

  factory Database() => _instance;

  Future<Map<String, dynamic>> getAllData() async {
    final body = json.encode({
      "id": _id,
      "table": "all",
    });
    try {
      final request = await HttpClient().getUrl(Uri.parse(_url));
      request.headers.contentType = ContentType.json;
      request.headers.contentLength = body.length;
      request.headers.add("key", _key);
      request.write(body);
      final response = await request.close();
      if (response.statusCode == 404) {
        return {"message": "was not found"};
      } else if (response.statusCode == 401) {
        return {"message": "there is something wrong"};
      }
      return json.decode(await response.transform(utf8.decoder).single);
    } on SocketException {
      return {"message": "connection error"};
    } catch (e) {
      print(e);
      return {"message": e.toString()};
    }
  }

  Future<Map<String, dynamic>> getDataByColumn(
      String table, String column, dynamic value) async {
    final body = json.encode({
      "id": _id,
      "table": table,
      "table_column": column,
      "table_value": value,
    });
    try {
      final request = await HttpClient().getUrl(Uri.parse(_url));
      request.headers.contentType = ContentType.json;
      request.headers.contentLength = body.length;
      request.headers.add("key", _key);
      request.write(body);
      final response = await request.close();
      if (response.statusCode == 404) {
        return {"message": "was not found"};
      } else if (response.statusCode == 401) {
        return {"message": "there is something wrong"};
      }
      return json.decode(await response.transform(utf8.decoder).single);
    } on SocketException {
      return {"message": "connection error"};
    } catch (e) {
      print(e);
      return {"message": e.toString()};
    }
  }

  Future<Map<String, dynamic>> createTable(
      String table, Map<String, dynamic> data) async {
    if (data["id"] == null)
      data["id"] = md5.convert(
          utf8.encode(DateTime.now().millisecondsSinceEpoch.toString())).toString();
    final body = json.encode({
      "id": _id,
      "table": table,
      table: data,
    });
    try {
      final request = await HttpClient().postUrl(Uri.parse(_url));
      request.headers.contentType = ContentType.json;
      request.headers.contentLength = body.length;
      request.headers.add("key", _key);
      request.write(body);
      final response = await request.close();
      if (response.statusCode == 400) {
        return {"message": "was not found"};
      } else if (response.statusCode == 401) {
        return {"message": "there is something wrong"};
      }
      return json.decode(await response.transform(utf8.decoder).single);
    } on SocketException {
      return {"message": "connection error"};
    } catch (e) {
      print(e);
      return {"message": e.toString()};
    }
  }

}
