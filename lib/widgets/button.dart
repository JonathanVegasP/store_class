import 'package:flutter/material.dart';

typedef _onPressed<T> = void Function(BuildContext,AsyncSnapshot<T>);

class Button<T> extends StatelessWidget {
  final _onPressed<T> onPressed;
  final Color color;
  final double borderRadius;
  final double padding;
  final Widget child;
  final Color textColor;
  final Stream<T> stream;

  const Button({
    Key key,
    @required this.onPressed,
    this.color = Colors.white,
    this.borderRadius = 12.0,
    this.padding = 12.0,
    this.textColor = Colors.black,
    this.child,
    this.stream,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      builder: (context, snapshot) {
        return RaisedButton(
          onPressed: () => onPressed(context,snapshot),
          color: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: EdgeInsets.all(padding),
          child: child,
          textColor: textColor,
        );
      },
      stream: stream,
    );
  }
}
