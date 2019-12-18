import 'package:flutter/material.dart';
import 'package:store/widgets/custom_app_bar.dart';
import 'package:store/widgets/dismiss_keyboard.dart';
import 'package:store/widgets/fill_screen.dart';

class NewSaleScreen extends StatefulWidget {
  @override
  _NewSaleScreenState createState() => _NewSaleScreenState();
}

class _NewSaleScreenState extends State<NewSaleScreen> {
  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: FillScreen(
        child: Column(
          children: <Widget>[
            CustomAppBar(),
            Padding(
              padding: EdgeInsets.all(32.0),
              child: Column(
                children: <Widget>[

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
