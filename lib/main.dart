import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/blocs/user_bloc.dart';
import 'package:store/screens/intro.dart';

class FlutterStore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = UserBloc();
    return Provider<UserBloc>(
      create: (_) => bloc,
      child: StreamBuilder(
        stream: bloc.outUser,
        builder: (context, snapshot) {
          return MaterialApp(
            title: "Flutter Store",
            theme: ThemeData(
              primaryColor: Colors.white,
              hintColor: Colors.white,
              inputDecorationTheme: InputDecorationTheme(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            home: IntroScreen(),
          );
        },
      ),
      dispose: (_, b) => b.dispose(),
    );
  }
}

void main() => runApp(FlutterStore());
