import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart'
    show CupertinoDialogAction, CupertinoAlertDialog;
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String content;
  final String positiveButton;
  final String negativeButton;
  final VoidCallback positiveButtonOnPressed;
  final VoidCallback negativeButtonOnPressed;

  const CustomDialog(
      {Key key,
      this.content,
      this.positiveButton,
      this.negativeButton,
      this.positiveButtonOnPressed,
      this.negativeButtonOnPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoAlertDialog(
            content: Text("Deseja realmente sair?"),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text(positiveButton),
                onPressed: positiveButtonOnPressed,
              ),
              negativeButtonOnPressed != null
                  ? CupertinoDialogAction(
                      child: Text(negativeButton),
                      onPressed: negativeButtonOnPressed,
                    )
                  : Container()
            ],
          )
        : AlertDialog(
            content: Text(
              content,
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: positiveButtonOnPressed,
                child: Text(positiveButton),
              ),
              negativeButtonOnPressed != null
                  ? FlatButton(
                      onPressed: negativeButtonOnPressed,
                      child: Text(negativeButton),
                    )
                  : Container()
            ],
          );
  }
}
