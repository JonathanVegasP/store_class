import 'package:flutter/material.dart';
import 'package:flutter_store/screens/add_products.dart';
import 'package:flutter_store/widgets/home_card_button.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(999.0),
        )),
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text("Flutter Store"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            HomeCardButton(
              title: "Adicionar Produtos",
              onPressed: () => navigator.push(
                MaterialPageRoute(
                  builder: (context) => AddProductScreen(),
                ),
              ),
              icon: Icons.add_to_photos,
            ),
            HomeCardButton(
              title: "Vendas",
              onPressed: () {},
              icon: Icons.shopping_cart,
            ),
          ],
        ),
      ),
    );
  }
}
