import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movies_app/Services/Firebase.dart';

import 'package:provider/provider.dart';

import 'buttons.dart';

class SignUpButtons extends StatefulWidget {
  final String regOrLogin;
  SignUpButtons({this.regOrLogin});
  @override
  _SignUpButtonsState createState() => _SignUpButtonsState();
}

var obsecure = true;
var isLoading = false;

class _SignUpButtonsState extends State<SignUpButtons> {
  final _formKey = GlobalKey<FormState>();
  Map<String, String> _authmap = {
    'email': "",
    'password': "",
    'name': "",
  };
  var futureValue = false;
  Future<bool> emailAvailable(String email) async {
    final response = await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: email)
        .get()
        .then((value) {
      if (value.docs.length == 0) {
        setState(() {
          futureValue = true;
        });
      } else {
        setState(() {
          futureValue = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    void _saveForm(String operation) async {
      try {
        final firebaseProvider =
            Provider.of<FirebaseServices>(context, listen: false);
        if (!_formKey.currentState.validate()) {
          return;
        }
        _formKey.currentState.save();
        if (operation == "REGISTER") {
          await firebaseProvider
              .signUpUser(_authmap["name"], _authmap["email"],
                  _authmap["password"], context)
              .then((value) => Navigator.pop(context))
              .catchError((e) {
            print(e);
          });
        }
        if (operation == "LOGIN") {
          setState(() {
            isLoading = true;
          });
          await firebaseProvider.SignInUser(
                  _authmap["email"], _authmap["password"], context)
              .then((value) => Navigator.pop(context))
              .catchError((e) {
            print(e);
          });
          setState(() {
            isLoading = false;
          });
        }
      } catch (e) {
        print(e);
      }
    }

    return Form(
      key: _formKey,
      child: Column(
        children: [
          widget.regOrLogin == "REGISTER"
              ? textFormField(false, "Username", () {})
              : Container(),
          SizedBox(
            height: 20,
          ),
          textFormField(false, "Email", () {}),
          SizedBox(
            height: 20,
          ),
          textFormField(obsecure, "Password", () {
            setState(() {
              obsecure = !obsecure;
            });
          }),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.yellow[700],
                    ),
                  )
                : CustomButton(
                    onPressedd: () {
                      _saveForm(widget.regOrLogin == "REGISTER"
                          ? "REGISTER"
                          : "LOGIN");
                    },
                    text:
                        widget.regOrLogin == "REGISTER" ? "SUBMIT" : "SIGN IN",
                  ),
          ),
        ],
      ),
    );
  }

  Widget textFormField(bool obsecure, String label, Function function) {
    return TextFormField(
        onChanged: (value) {
          if (label == "Email" &&
              (value.contains("@") && value.contains(".com"))) {
            emailAvailable(value);
          } else {
            setState(() {
              futureValue = false;
            });
          }
        },
        obscureText: obsecure,
        onSaved: (newValue) {
          if (label == "Username") {
            _authmap["name"] = newValue.trim();
          } else if (label == "Email") {
            _authmap["email"] = newValue.trim();
          } else if (label == "Password") {
            _authmap["password"] = newValue.trim();
          }
        },
        validator: (value) {
          if (label == "Username") {
            if (value.isEmpty) {
              return ("Username is required !");
            } else if (value.length < 3) {
              return ("Minimum username length is 3");
            }
          }
          if (label == "Email") {
            if (value.isEmpty) {
              return ("Email is required !");
            } else if (!value.contains("@") || !value.contains(".com")) {
              return ("Please enter a valid email !");
            }
          }
          if (label == "Password") {
            if (value.isEmpty) {
              return ("Password is required !");
            } else if (value.length < 5) {
              // setState(() {
              //   widget.iconColor = Colors.red;
              // });
              function();
              return ("Password is too short minimun is 5");
            }
          }
        },
        style: TextStyle(color: Colors.white),
        cursorColor: Colors.yellow,
        decoration: InputDecoration(
          errorStyle: TextStyle(letterSpacing: 2, fontSize: 12),
          suffixIcon: label == "Password"
              ? InkWell(
                  onTap: () {
                    function();
                  },
                  child: Container(
                    padding: EdgeInsets.only(right: 8),
                    child: Image.asset(
                      "assets/images/batman_logo.png",
                      width: 3,
                      height: 5,
                    ),
                  ),
                )
              : label == "Email" && widget.regOrLogin == "REGISTER"
                  ? futureValue
                      ? Container(
                          padding: EdgeInsets.all(15),
                          child: FaIcon(
                            FontAwesomeIcons.check,
                            color: Colors.green,
                          ),
                        )
                      : Container(
                          padding: EdgeInsets.all(15),
                          child: FaIcon(
                            FontAwesomeIcons.times,
                            color: Colors.red,
                          ))
                  : null,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.white, width: 1)),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: label,
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
