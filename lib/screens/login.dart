import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/blocs/login_bloc.dart';
import 'package:store/blocs/user_bloc.dart';
import 'package:store/screens/home.dart';
import 'package:store/widgets/button.dart';
import 'package:store/widgets/dismiss_keyboard.dart';
import 'package:store/widgets/input_field.dart';
import 'package:store/widgets/logo_widget.dart';
import 'package:store/widgets/vollup_logo.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _bloc = LoginBloc();

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final focus = FocusScope.of(context);
    return DismissKeyboard(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          color: Colors.black87,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              SafeArea(
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  LogoWidget(),
                                  SizedBox(
                                    height: 32.0,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  InputField(
                                    onChanged: _bloc.inEmail,
                                    stream: _bloc.outEmail,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.emailAddress,
                                    labelText: "Digite o seu usuário",
                                    prefixIcon: Icons.person_outline,
                                    onSubmitted: (_) =>
                                        focus.requestFocus(_bloc.passwordFN),
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  InputField(
                                    onChanged: _bloc.inPassword,
                                    stream: _bloc.outPassword,
                                    obscureText: true,
                                    prefixIcon: Icons.lock_outline,
                                    labelText: "Digite a sua senha",
                                    focusNode: _bloc.passwordFN,
                                  ),
                                  SizedBox(
                                    height: 16.0,
                                  ),
                                  StreamBuilder<String>(
                                    stream: _bloc.outError,
                                    initialData: "",
                                    builder: (context, snapshot) {
                                      return Center(
                                        heightFactor: 1,
                                        child: Text(
                                          snapshot.data,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(
                                    height: 56.0,
                                  ),
                                  StreamBuilder<bool>(
                                    stream: _bloc.outValidate,
                                    builder: (context, snapshot) {
                                      return Button(
                                        onPressed: () async {
                                          focus.unfocus();
                                          if (snapshot.hasData) {
                                            final result = await _bloc.signIn(
                                                Provider.of<UserBloc>(context));
                                            if (result)
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomeScreen(),
                                                ),
                                              );
                                          }
                                        },
                                        child: Text(
                                          "Acessar a conta",
                                          style: TextStyle(
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 32.0,
                                  ),
                                  VollupLogo(),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              StreamBuilder(
                stream: _bloc.outState,
                initialData: LoginState.IDLE,
                builder: (context, snapshot) {
                  return snapshot.data == LoginState.LOADING
                      ? Container(
                          color: Colors.black54,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                              SizedBox(
                                height: 16.0,
                              ),
                              Text(
                                "Carregando...",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                        )
                      : Container();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
