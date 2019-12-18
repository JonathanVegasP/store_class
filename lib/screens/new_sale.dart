import 'package:flutter/material.dart';
import 'package:store/widgets/button.dart';
import 'package:store/widgets/custom_app_bar.dart';
import 'package:store/widgets/dismiss_keyboard.dart';
import 'package:store/widgets/fill_screen.dart';
import 'package:store/widgets/input_field.dart';

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
                  InputField(
                    labelText: "Produto",
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                    margin: EdgeInsets.symmetric(vertical: 32.0),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text("Quantidade Total"),
                              Text("3"),
                            ],
                          ),
                          Divider(
                            color: Colors.black,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text("Total"),
                              Text("R\$ 5.99"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Button(
                    onPressed: (context, snapshot) {},
                    child: Text(
                      "Adicionar no Carrinho".toUpperCase(),
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
