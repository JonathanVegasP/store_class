import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/blocs/user_bloc.dart';
import 'package:store/data/product_data.dart';
import 'package:store/resources/colors.dart';
import 'package:store/widgets/button.dart';
import 'package:store/widgets/custom_app_bar.dart';
import 'package:store/widgets/dismiss_keyboard.dart';
import 'package:store/widgets/fill_screen.dart';
import 'package:store/widgets/input_field.dart';
import 'package:store/widgets/title_style.dart';

class NewSaleScreen extends StatefulWidget {
  @override
  _NewSaleScreenState createState() => _NewSaleScreenState();
}

class _NewSaleScreenState extends State<NewSaleScreen> {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<UserBloc>(context);
    return DismissKeyboard(
      child: FillScreen(
        child: Column(
          children: <Widget>[
            CustomAppBar(),
            Padding(
              padding: EdgeInsets.all(32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  InputField<ProductData>(
                    labelText: "Produto",
                    items: (data) async {
                      final list = products.products;
                      print(products.products);
                      list.retainWhere((el) => el.title
                          .trim()
                          .toLowerCase()
                          .contains(data.trim().toLowerCase()));
                      return list;
                    },
                    onItemPressed: (item) {
                      return item.title;
                    },
                    itemBuilder: (context, item) {
                      return ListTile(
                        leading: Image.memory(base64.decode(item.image)),
                        title: Text(item.title),
                      );
                    },
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
                            height: 2,
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
                  SizedBox(
                    height: 32.0,
                  ),
                  Button(
                    onPressed: (context, snapshot) {},
                    child: Text(
                      "Adicionar no Carrinho".toUpperCase(),
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  Card(
                    color: BackgroundColor,
                    margin: EdgeInsets.symmetric(vertical: 32.0),
                    child: ExpansionTile(
                      title: Text(
                        "Carrinho",
                        style: TitleStyle(),
                      ),

                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
