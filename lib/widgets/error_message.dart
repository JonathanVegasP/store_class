import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final Stream<String> stream;

  const ErrorMessage({Key key, this.stream}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: stream,
      initialData: "",
      builder: (context, snapshot) {
        return Text(
          snapshot.data,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12.0,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        );
      },
    );
  }
}
