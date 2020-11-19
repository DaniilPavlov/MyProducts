import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthInput extends StatelessWidget {
  AuthInput(
      {Key key,
      @required this.inputController,
      @required this.placeholderText,
      @required this.obscureText,})
      : super(key: key);

  final TextEditingController inputController;
  final String placeholderText;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: placeholderText,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20.0)),
      ),
      style: TextStyle(
        fontSize: 24,
      ),
      obscureText: obscureText,
      validator: (value) {
        if (value.isEmpty) {
          return 'Пожалуйста введите ваши данные';
        }
        return null;
      },
      controller: inputController,
      onChanged: (value) {
        print(inputController.text);
      },
    );
  }
}