import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/blocs/user_bloc.dart';
import 'package:store/screens/home.dart';
import 'package:store/widgets/logo_widget.dart';

import 'login.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await Future.delayed(Duration(seconds: 3));
    final isLogged = await Provider.of<UserBloc>(context).initialize();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => isLogged ? HomeScreen() : LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.black87,
        child: Center(
          child: LogoWidget(),
        ),
      ),
    );
  }
}
