class UserData {
  String name;
  String email;
  String password;

  UserData(this.name, this.email, this.password);

  UserData.fromJson(Map<String, dynamic> map) {
    name = map["name"];
    email = map["email"];
    password = map["password"];
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "password": password,
    };
  }
}
