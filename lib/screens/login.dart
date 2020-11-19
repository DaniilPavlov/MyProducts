import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:products_control/models/user.dart';
import 'package:products_control/services/auth.dart';

import 'loading.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String _email;
  String _password;
  bool showLogin = true;

  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    Widget _logotype() {
      return Padding(
        padding: EdgeInsets.only(top: 100, left: 20, right: 20),
        child: Container(
          child: Align(
            child: Text(
              'Добро пожаловать в MyProducts!',
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
      );
    }

    Widget _input(Icon icon, String hint, TextEditingController controller,
        bool obscure) {
      return Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: TextField(
            controller: controller,
            obscureText: obscure,
            style: TextStyle(fontSize: 20, color: Colors.white),
            decoration: InputDecoration(
                hintStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white38),
                hintText: hint,
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 3)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white60, width: 1)),
                prefixIcon: Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: IconTheme(
                    data: IconThemeData(color: Colors.white),
                    child: icon,
                  ),
                ))),
      );
    }

    Widget _button(String text, void func()) {
      return RaisedButton(
        splashColor: Colors.white,
        highlightColor: Colors.black,
        color: Colors.white,
        child: Text(text,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
                fontSize: 20)),
        onPressed: () {
          func();
        },
      );
    }

    Widget _form(String label, void func()) {
      return Container(
          child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 20, top: 10),
            child: _input(Icon(Icons.email), "Логин", _emailController, false),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child:
                _input(Icon(Icons.lock), "Пароль", _passwordController, true),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: _button(label, func),
            ),
          )
        ],
      ));
    }

    void _buttonLogin() async {

      _email = _emailController.text;
      _password = _passwordController.text;
      if (_email.isEmpty || _password.isEmpty) return;

      User user = await _authService.emailAndPasswordLogIn(
          _email.trim(), _password.trim());
      if (user == null) {
        Fluttertoast.showToast(
            msg: "Error. Please check your email and password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            textColor: Colors.deepPurple,
            fontSize: 16.0);
      } else {
        _emailController.clear();
        _passwordController.clear();
      }
    }

    void _buttonRegistration() async {
      _email = _emailController.text;
      _password = _passwordController.text;

      if (_email.isEmpty || _password.isEmpty) return;

      User user = await _authService.emailAndPasswordReg(
          _email.trim(), _password.trim());
      if (user == null) {
        Fluttertoast.showToast(
            msg: "Error. Please check your email and password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            textColor: Colors.deepPurple,
            fontSize: 16.0);
      } else {
        _emailController.clear();
        _passwordController.clear();
      }
    }

    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/login-screen.webp"),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              children: <Widget>[
                _logotype(),
                SizedBox(height: 50),
                (showLogin
                    ? Column(
                        children: <Widget>[
                          _form('Вход', _buttonLogin),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: GestureDetector(
                                child: Text(
                                  'Еще не зарегистрированы?',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                                onTap: () {
                                  setState(() {
                                    showLogin = false;
                                  });
                                }),
                          )
                        ],
                      )
                    : Column(
                        children: <Widget>[
                          _form('Регистрация', _buttonRegistration),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: GestureDetector(
                                child: Text(
                                  'Уже зарегистрированы?',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                                onTap: () {
                                  setState(() {
                                    showLogin = true;
                                  });
                                }),
                          )
                        ],
                      )),
              ],
            )));
  }
}
