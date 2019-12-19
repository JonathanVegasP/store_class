import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class Database {
  final String _key = "c33367701511b4f6020ec61ded352059";
  final String _id = "com.vollup.store";
  final String _url = "https://flutter-store.herokuapp.com/database";

  static final Database _instance = Database._internal();

  Database._internal();

  factory Database() => _instance;

  Future<Map<String, dynamic>> getAllData() async {
    try {
      final request = http.Request("GET", Uri.parse("$_url/all"));
      request.headers["Content-Type"] = "application/json";
      request.headers["key"] = _key;
      request.headers["id"] = _id;
      final response = await request.send();
      if (!request.finalized) request.finalize();
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return json.decode(await utf8.decodeStream(response.stream));
      } else {
        return {
          "status": response.statusCode,
          "headers": response.headers,
          "body": await response.stream.transform(utf8.decoder).single
        };
      }
    } on SocketException {
      return {
        "message":
            "Não foi possível conectar com o servidor, tente novamente mais tarde"
      };
    } catch (e) {
      print(e);
      return {
        "error": e.toString(),
      };
    }
  }

  Future<Map<String, dynamic>> getDataByTable(String table) async {
    final request = http.Request("GET", Uri.parse("$_url/$table"));
    request.persistentConnection = true;
    request.headers["Content-Type"] = "application/json";
    request.headers["key"] = _key;
    request.headers["id"] = _id;
    final response = await request.send();
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return json.decode(await utf8.decodeStream(response.stream));
    } else {
      return {
        "status": response.statusCode,
        "headers": response.headers,
        "body": await utf8.decodeStream(response.stream)
      };
    }
  }

  Future<Map<String, dynamic>> getDataByJson(
      String table, Map<String, dynamic> map) async {
    try {
      String queryUrl = "";
      int i = 0;
      while (i < map.keys.length) {
        if (i == 0)
          queryUrl += "${map.keys.elementAt(i)}=${map[map.keys.elementAt(i)]}";
        else
          queryUrl += "&${map.keys.elementAt(i)}=${map[map.keys.elementAt(i)]}";
        i++;
      }
      final request = http.Request("GET", Uri.parse("$_url/$table?$queryUrl"));
      request.headers["Content-Type"] = "application/json";
      request.headers["key"] = _key;
      request.headers["id"] = _id;
      final response = await request.send();
      if (!request.finalized) request.finalize();
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return json
            .decode(await response.stream.transform(utf8.decoder).single);
      } else {
        return {
          "status": response.statusCode,
          "headers": response.headers,
          "body": await response.stream.transform(utf8.decoder).single
        };
      }
    } on SocketException {
      return {
        "message":
            "Não foi possível conectar com o servidor, tente novamente mais tarde"
      };
    } catch (e) {
      print(e);
      return {
        "error": e.toString(),
      };
    }
  }

  Future<Map<String, dynamic>> createTable(
      String table, Map<String, dynamic> data) async {
    try {
      final body = utf8.encode(json.encode(data));
      final request = http.Request("POST", Uri.parse("$_url/$table"));
      request.headers["Content-Type"] = "application/json";
      request.headers["key"] = _key;
      request.headers["id"] = _id;
      request.bodyBytes = body;
      final response = await request.send();
      if (!request.finalized) request.finalize();
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return json
            .decode(await response.stream.transform(utf8.decoder).single);
      } else {
        return {
          "status": response.statusCode,
          "headers": response.headers,
          "body": await response.stream.transform(utf8.decoder).single
        };
      }
    } on SocketException {
      return {
        "message":
            "Não foi possível conectar com o servidor, tente novamente mais tarde"
      };
    } catch (e) {
      print(e);
      return {
        "error": e.toString(),
      };
    }
  }

  Future<Map<String, dynamic>> updateDataById(
      String table, String id, Map<String, dynamic> data) async {
    try {
      final body = json.encode(data);
      final request = await HttpClient().putUrl(Uri.parse("$_url/$table"));
      request.headers.add("key", _key);
      request.headers.add("id", _id);
      request.headers.contentType = ContentType.json;
      request.headers.contentLength = -1;
      request.encoding = AsciiCodec();
      request.write(body);
      final response = await request.close();
      if (response.statusCode == 403) {
        return {"message": "this data don't contains any id"};
      } else if (response.statusCode == 401) {
        return {"message": "there is something wrong"};
      } else if (response.statusCode == 200) {
        return json.decode(await response.transform(utf8.decoder).single);
      } else if (response.statusCode == 404) {
        return {"message": "the data was not found"};
      } else if (response.statusCode == 400) {
        return {"message": "was not possible to update"};
      } else {
        return {"message": "error, try again later"};
      }
    } catch (e) {
      print(e);
      return {"message": e.toString()};
    }
  }
}
