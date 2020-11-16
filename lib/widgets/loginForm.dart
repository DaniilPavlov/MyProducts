import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../services/auth.dart';
import './input.dart';
import '../screens/navContainer.dart';
import '../screens/loading.dart';

class LoginForm extends StatefulWidget {
  LoginForm({Key key, @required this.authService}) : super(key: key);

  final AuthService authService;

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  // TODO: figure out how this works and if I need it
  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                'Добро пожаловать в MyProducts!',
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 6.0, vertical: 15.0),
            child: Text(
              'Имя пользователя',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Input(
            inputController: _usernameController,
            placeholderText: 'Введите ваш логин',
            obscureText: false,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 6.0, vertical: 15.0),
            child: Text(
              'Пароль',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Input(
            inputController: _passwordController,
            placeholderText: 'Введите ваш пароль',
            obscureText: true,
          ),
          Padding(
            padding: EdgeInsets.only(top: 30.0),
            child: ButtonTheme(
              minWidth: 400.0,
              height: 60.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              buttonColor: Colors.black,
              splashColor: Colors.grey,
              child: RaisedButton(
                  child: Text(
                    'Google Account',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return LoadingScreen();
                        },
                      ),
                    );
                    widget.authService.loginWithGoogle().whenComplete(() {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return NavContainerScreen(
                                authService: widget.authService);
                          },
                        ),
                      );
                    });
                  }),
            ),
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }
}
