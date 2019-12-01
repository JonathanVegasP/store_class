import 'package:flutter_store/data/user_data.dart';

class UserBloc {
  final UserData userData;
  UserBloc(this.userData);

  void dispose() {
    print("funcionou");
  }
}
