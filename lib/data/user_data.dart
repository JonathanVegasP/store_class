class UserData {
  String id;
  String name;
  String email;
  String password;

  UserData(this.name, this.email, this.password);

  UserData.fromJson(Map<String, dynamic> map) {
    id = map["id"];
    name = map["name"];
    email = map["email"];
    password = map["password"];
  }

  Map<String, dynamic> toJson() {
    final map = {
      "name": name,
      "email": email,
      "password": password,
    };
    if(id != null) {
      map["id"] = id;
    }
    return map;
  }
}
