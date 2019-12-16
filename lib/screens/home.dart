import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/blocs/user_bloc.dart';
import 'package:store/resources/images.dart';
import 'package:store/screens/add_product.dart';
import 'package:store/screens/login.dart';
import 'package:store/storage/file_manager.dart';
import 'package:store/storage/files.dart';
import 'package:store/widgets/custom_dialog.dart';
import 'package:store/widgets/fill_screen.dart';
import 'package:store/widgets/home_card_button.dart';
import 'package:store/widgets/logo_widget.dart';
import 'package:store/widgets/vollup_logo.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<UserBloc>(context);
    final navigator = Navigator.of(context);
    return FillScreen(
      child: Padding(
        padding: EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                LogoWidget(),
                SizedBox(
                  height: 32.0,
                ),
                Text(
                  "Olá, ${bloc.user?.name ?? ""}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                HomeCardButton(
                  backgroundColor: Colors.black,
                  onPressed: () => navigator.push(
                    MaterialPageRoute(
                      builder: (context) => AddProductScreen(),
                    ),
                  ),
                  title: "Adicionar Produtos",
                  icon: Icons.add_circle_outline,
                ),
                HomeCardButton(
                  onPressed: () => false,
                  title: "Efetuar uma Venda",
                  image: BolsaImage,
                ),
                FlatButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => CustomDialog(
                        content: "Deseja realmente sair?",
                        negativeButton: "Não".toUpperCase(),
                        negativeButtonOnPressed: () => navigator.pop(),
                        positiveButton: "Sim".toUpperCase(),
                        positiveButtonOnPressed: () async {
                          navigator.pop();
                          navigator.pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                          await FileManager(UserFile).deleteAllFiles();
                        },
                      ),
                    );
                  },
                  child: Text(
                    "Sair",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                )
              ],
            ),
            VollupLogo(),
          ],
        ),
      ),
    );
  }
}
