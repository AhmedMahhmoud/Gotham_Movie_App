import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FirebaseServices with ChangeNotifier {
  final _auth = FirebaseAuth.instance;

  void showErrorDiaglog(String title, String message, BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(title),
              content: Text(message),
              actions: [
                FlatButton(
                  child: Text('Okay'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ));
  }

  Future<void> signUpUser(String username, String userEmail,
      String userPassword, BuildContext context) async {
    try {
      final UserCredential user = await _auth
          .createUserWithEmailAndPassword(
              email: userEmail.trim(), password: userPassword.trim())
          .catchError((e) {
        if (e.toString().contains("already in use by another account"))
          showErrorDiaglog("Register Failed",
              "The email address is already in use", context);
        else
          showErrorDiaglog("Register Failed",
              "Something went wrong please try again later", context);
      });
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.user.uid)
          .set({
        "username": username.trim(),
        "email": userEmail.trim(),
      }).then((value) =>
              _auth.currentUser.updateProfile(displayName: username));
    } catch (e) {
      print(e);
    }
  }

  Future <void> SignInUser(String email, String password, BuildContext context) async{
    try
    {
     final user = await _auth
        .signInWithEmailAndPassword(email: email, password: password).catchError((e){
          if (e.toString().contains("The password is invalid"))
            showErrorDiaglog("Sign in Failed",
                "Wrong password", context);
          else if(e.toString().contains("There is no user record corresponding to this identifier"))
            showErrorDiaglog("Sign in Failed",
            "Invalid email", context);
        });
          
    }
    catch(e)
    {
      print(e);
    }

  }

}
