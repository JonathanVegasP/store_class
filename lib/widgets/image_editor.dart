import 'dart:io' show File;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageEditor extends StatelessWidget {
  final Stream<File> stream;

  const ImageEditor({Key key, this.stream}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<File>(
      stream: stream,
      builder: (context, snapshot) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12.0),
                image: snapshot.hasData
                    ? DecorationImage(
                        image: FileImage(snapshot.data),
                        fit: BoxFit.fill,
                      )
                    : null,
                border: snapshot.hasError
                    ? Border.all(
                        color: Colors.red,
                        width: 2,
                      )
                    : Border(),
              ),
              child: Center(
                child: snapshot.hasData
                    ? Container()
                    : Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 50,
                      ),
              ),
            ),
            SizedBox(
              height: 4.0,
            ),
            Text(
              snapshot.error ?? "",
              style: TextStyle(
                color: Colors.red,
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        );
      },
    );
  }
}
