import 'package:flutter/material.dart';
import 'package:store/resources/colors.dart';

class FillScreen extends StatelessWidget {
  final Widget child;

  const FillScreen({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackgroundColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, view) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: view.maxHeight,
                  minWidth: view.maxWidth,
                ),
                child: child,
              ),
            );
          },
        ),
      ),
    );
  }
}
