import 'package:flutter/material.dart';
import 'package:flutter_store/screens/intro.dart';

class FlutterStore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Store",
      home: IntroScreen(),
    );
  }
}

void main() => runApp(FlutterStore());
