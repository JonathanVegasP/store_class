import 'package:flutter/material.dart';
import 'package:store/widgets/logo_widget.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          BackButton(
            color: Colors.white,
          ),
          LogoWidget(
            width: 150,
          ),
          Container(),
        ],
      ),
    );
  }
}
