import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store/blocs/add_product_bloc.dart';
import 'package:store/widgets/button.dart';
import 'package:store/widgets/dismiss_keyboard.dart';
import 'package:store/widgets/logo_widget.dart';

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _bloc = AddProductBloc();

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    return DismissKeyboard(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          color: Colors.black87,
          child: LayoutBuilder(
            builder: (context, view) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: view.maxHeight,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(32.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            BackButton(
                              color: Colors.white,
                            ),
                            LogoWidget(
                              width: 150,
                            ),
                            Container(),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Platform.isIOS
                                        ? CupertinoAlertDialog(
                                            content:
                                                Text("Selecione uma foto:"),
                                            actions: <Widget>[
                                              CupertinoDialogAction(
                                                child: Text("Galeria"),
                                                onPressed: () {
                                                  navigator.pop();
                                                  _bloc.getImageFromGallery();
                                                },
                                              ),
                                              CupertinoDialogAction(
                                                child: Text("Camera"),
                                                onPressed: () {
                                                  navigator.pop();
                                                  _bloc.getImageFromCamera();
                                                },
                                              ),
                                            ],
                                          )
                                        : AlertDialog(
                                            elevation: 2.0,
                                            content: Text(
                                              "Selecione uma foto:",
                                              textAlign: TextAlign.center,
                                            ),
                                            actions: <Widget>[
                                              FlatButton(
                                                child: Text("Galeria"),
                                                onPressed: () {
                                                  navigator.pop();
                                                  _bloc.getImageFromGallery();
                                                },
                                              ),
                                              FlatButton(
                                                child: Text("Camera"),
                                                onPressed: () {
                                                  navigator.pop();
                                                  _bloc.getImageFromCamera();
                                                },
                                              )
                                            ],
                                          );
                                  },
                                );
                              },
                              child: StreamBuilder<File>(
                                stream: _bloc.outImage,
                                builder: (context, snapshot) {
                                  return Container(
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
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: 16.0,
                            ),
                            TextField(
                              decoration: InputDecoration(
                                labelText: "Produto",
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      labelText: "Quantidade",
                                    ),
                                    keyboardType:
                                        TextInputType.numberWithOptions(),
                                  ),
                                ),
                                SizedBox(
                                  width: 16.0,
                                ),
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      labelText: "Preço",
                                      prefixText: "R\$ ",
                                    ),
                                    keyboardType:
                                        TextInputType.numberWithOptions(),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            TextField(
                              decoration: InputDecoration(
                                labelText: "Código de Barras",
                              ),
                            ),
                          ],
                        ),
                        StreamBuilder<bool>(
                          builder: (context, snapshot) {
                            return Button(
                              onPressed: () {
                                if (snapshot.hasData) {}
                              },
                              child: Text("Adicionar"),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
