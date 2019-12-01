import 'package:flutter/material.dart';
import 'package:flutter_store/widgets/dismiss_keyboard.dart';

class AddProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(999.0),
            ),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            "Adicionar Produto",
            style: TextStyle(color: Colors.black),
          ),
          leading: Padding(
            padding: EdgeInsets.only(
              left: 24,
            ),
            child: BackButton(
              color: Colors.black,
            ),
          ),
        ),
        body: LayoutBuilder(
          builder: (context, view) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: view.maxWidth,
                  minHeight: view.maxHeight,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Theme(
                      data: ThemeData(
                        primaryColor: Colors.white,
                        hintColor: Colors.white,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          children: <Widget>[
                            TextField(
                              decoration: InputDecoration(
                                labelText: "Produto",
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Scrollbar(
                              child: TextField(
                                decoration:
                                    InputDecoration(labelText: "Descrição"),
                                minLines: 4,
                                maxLines: 4,
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            TextField(
                              decoration: InputDecoration(
                                labelText: "Preço",
                                prefixText: "R\$ ",
                              ),
                            ),
                            SizedBox(
                              height: 48,
                            )
                          ],
                        ),
                      ),
                    ),
                    RaisedButton(
                      padding: EdgeInsets.all(16.0),
                      onPressed: () {},
                      color: Colors.white,
                      textColor: Colors.black,
                      child: Text(
                        "Salvar".toUpperCase(),
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
