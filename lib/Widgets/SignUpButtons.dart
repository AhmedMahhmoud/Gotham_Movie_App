import 'dart:ui';

import 'package:flutter/material.dart';

import 'buttons.dart';

class SignUpButtons extends StatefulWidget {
  final String regOrLogin;
  SignUpButtons({this.regOrLogin});
  @override
  _SignUpButtonsState createState() => _SignUpButtonsState();
}

class _SignUpButtonsState extends State<SignUpButtons> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    void _saveForm() {
      if (!_formKey.currentState.validate()) {
        return;
      }
      print("form validated");
    }

    return Form(
      key: _formKey,
      child: Column(
        children: [
          widget.regOrLogin == "REGISTER"
              ? FormRegisterButton(
                  label: "Username",
                  obscure: false,
                )
              : Container(),
          SizedBox(
            height: 20,
          ),
          FormRegisterButton(
            label: "Email",
            obscure: false,
          ),
          SizedBox(
            height: 20,
          ),
          FormRegisterButton(
            label: "Password",
            obscure: true,
            iconColor: Colors.white,
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CustomButton(
              onPressedd: () {
                _saveForm();
              },
              text: widget.regOrLogin == "REGISTER" ? "SUBMIT" : "SIGN IN",
            ),
          ),
        ],
      ),
    );
  }
}

class FormRegisterButton extends StatefulWidget {
  FormRegisterButton({this.label, this.obscure, this.iconColor});

  final String label;
  bool obscure;
  Color iconColor;

  @override
  _FormRegisterButtonState createState() => _FormRegisterButtonState();
}

class _FormRegisterButtonState extends State<FormRegisterButton> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        obscureText: widget.obscure,
        validator: (value) {
          if (widget.label == "Username") {
            if (value.isEmpty) {
              return ("Username is required !");
            } else if (value.length < 3) {
              return ("Minimum username length is 3");
            }
          }
          if (widget.label == "Email") {
            if (value.isEmpty) {
              return ("Email is required !");
            } else if (!value.contains("@") || !value.contains(".com")) {
              return ("Please enter a valid email !");
            }
          }
          if (widget.label == "Password") {
            if (value.isEmpty) {
              return ("Password is required !");
            } else if (value.length < 5) {
              setState(() {
                widget.iconColor = Colors.red;
              });
              return ("Password is too short minimun is 5");
            }
          }
        },
        style: TextStyle(color: Colors.white),
        cursorColor: Colors.yellow,
        decoration: InputDecoration(
          errorStyle: TextStyle(letterSpacing: 2, fontSize: 12),
          suffixIcon: widget.label == "Password"
              ? InkWell(
                  onTap: () {
                    setState(() {
                      widget.obscure = !widget.obscure;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.only(right: 8),
                    child: Image.asset(
                      "assets/images/batman_logo.png",
                      color: widget.iconColor,
                      width: 3,
                      height: 5,
                    ),
                  ),
                )
              : null,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.white, width: 1)),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: widget.label,
          labelStyle: TextStyle(
              color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
        ));
  }
}
