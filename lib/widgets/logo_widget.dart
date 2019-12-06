import 'package:flutter/material.dart';
import 'package:store/resources/images.dart';

class LogoWidget extends StatelessWidget {
  final double width;
  final double height;

  const LogoWidget({Key key, this.width: 250.0, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "logo",
      child: Image.asset(
        LogoImage,
        width: width,
        height: height,
        fit: BoxFit.contain,
      ),
    );
  }
}
