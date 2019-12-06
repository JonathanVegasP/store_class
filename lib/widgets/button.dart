import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final VoidCallback onPressed;
  final Color color;
  final double borderRadius;
  final double padding;
  final Widget child;
  final Color textColor;

  const Button({
    Key key,
    @required this.onPressed,
    this.color = Colors.white,
    this.borderRadius = 12.0,
    this.padding = 12.0,
    this.textColor = Colors.black,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      padding: EdgeInsets.all(padding),
      child: child,
      textColor: textColor,
    );
  }
}
