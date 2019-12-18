import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:store/blocs/add_product_bloc.dart';
import 'package:store/widgets/button.dart';
import 'package:store/widgets/custom_app_bar.dart';
import 'package:store/widgets/custom_dialog.dart';
import 'package:store/widgets/dismiss_keyboard.dart';
import 'package:store/widgets/error_message.dart';
import 'package:store/widgets/fill_screen.dart';
import 'package:store/widgets/image_editor.dart';
import 'package:store/widgets/input_field.dart';
import 'package:store/widgets/loading.dart';
import 'package:mask/mask.dart';

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
    final focus = FocusScope.of(context);
    return DismissKeyboard(
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          FillScreen(
            child: Column(
              children: <Widget>[
                CustomAppBar(),
                Padding(
                  padding: EdgeInsets.all(32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => CustomDialog(
                              content: "Selecione uma foto:",
                              negativeButton: "Camera",
                              positiveButton: "Galeria",
                              negativeButtonOnPressed: () {
                                navigator.pop();
                                _bloc.getImageFromCamera();
                              },
                              positiveButtonOnPressed: () {
                                navigator.pop();
                                _bloc.getImageFromGallery();
                              },
                            ),
                          );
                        },
                        child: ImageEditor(
                          stream: _bloc.outImage,
                        ),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      InputField(
                        labelText: "Produto",
                        onSubmitted: (_) =>
                            focus.requestFocus(_bloc.quantityFN),
                        textInputAction: TextInputAction.next,
                        onChanged: _bloc.inTitle,
                        stream: _bloc.outTitle,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: InputField(
                              stream: _bloc.outQuantity,
                              onChanged: _bloc.inQuantity,
                              inputFormatters: [
                                WhitelistingTextInputFormatter.digitsOnly,
                              ],
                              focusNode: _bloc.quantityFN,
                              keyboardType: TextInputType.numberWithOptions(),
                              labelText: "Quantidade",
                              onSubmitted: (_) =>
                                  focus.requestFocus(_bloc.priceFN),
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                          SizedBox(
                            width: 16.0,
                          ),
                          Expanded(
                            child: InputField(
                              focusNode: _bloc.priceFN,
                              stream: _bloc.outPrice,
                              onChanged: _bloc.inPrice,
                              prefixText: "R\$ ",
                              textInputAction: TextInputAction.next,
                              onSubmitted: (_) =>
                                  focus.requestFocus(_bloc.barcodeFN),
                              labelText: "Preço",
                              keyboardType: TextInputType.numberWithOptions(),
                              inputFormatters: [
                                WhitelistingTextInputFormatter.digitsOnly,
                                MoneyMask(),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      InputField(
                        labelText: "Código de Barras",
                        onChanged: _bloc.inBarcode,
                        stream: _bloc.outBarcode,
                        focusNode: _bloc.barcodeFN,
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      ErrorMessage(
                        stream: _bloc.outError,
                      ),
                      SizedBox(
                        height: 56.0,
                      ),
                      Button<bool>(
                        stream: _bloc.outValidate,
                        onPressed: (context,snapshot) async {
                          if (snapshot.hasData) {
                            final result = await _bloc.addProduct();
                            if (result)
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) => CustomDialog(
                                  content: "Produto adicionado com sucesso!",
                                  positiveButton: "OK",
                                  positiveButtonOnPressed: () {
                                    while (navigator.canPop()) {
                                      navigator.pop();
                                    }
                                  },
                                ),
                              );
                          } else {
                            _bloc.validateFields();
                          }
                        },
                        child: Text("Adicionar"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          StreamBuilder<AddProductState>(
            stream: _bloc.outState,
            initialData: AddProductState.IDLE,
            builder: (context, snapshot) {
              return snapshot.data == AddProductState.LOADING
                  ? Loading()
                  : Container();
            },
          )
        ],
      ),
    );
  }
}
