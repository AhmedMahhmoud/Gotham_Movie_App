import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FirebaseServices with ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser;
  List<dynamic> myFavourites = [];
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
      }).then((value) async {
        await FirebaseFirestore.instance
            .collection("favourites")
            .doc(user.user.uid)
            .set({"id": ""});
      }).then((value) =>
              _auth.currentUser.updateProfile(displayName: username));
    } catch (e) {
      print(e);
    }
  }

  Future<void> addFav(String movieID, List<dynamic> dynamicList) async {
    int counter = 0;

    try {
      await FirebaseFirestore.instance
          .collection("favourites")
          .doc(user.uid)
          .get()
          .then((value) async {
        value.data().forEach((key, value) {
          if (key == movieID) {
            counter++;
          }
        });
        if (counter == 0) {
          await FirebaseFirestore.instance
              .collection("favourites")
              .doc(user.uid)
              .set(
            {"$movieID": dynamicList},
            SetOptions(merge: true),
          );
        }
      });
    } catch (e) {
      print(e);
    }
  }

  Future<List<dynamic>> getFavMovies() async {
    myFavourites = [];
    List<dynamic> myNewList = [];
    await FirebaseFirestore.instance
        .collection("favourites")
        .doc(user.uid)
        .get()
        .then((value) {
      value.data().forEach((key, value) {
        if (value[0] == true) {
          myNewList = [value[0], value[1], value[2]];
          myFavourites.add(myNewList);
        }
      });
      return myFavourites;
    });
  }

  Future<void> toggleFav(String movieID) async {
    List<dynamic> myNewList = [];

    await FirebaseFirestore.instance
        .collection("favourites")
        .doc(user.uid)
        .get()
        .then((value) {
      var isFav = value.data()[movieID][0];
      var movieTitle = value.data()[movieID][1];
      var moviePoster = value.data()[movieID][2];
      myNewList.clear();
      myNewList = [!isFav, movieTitle, moviePoster];

      FirebaseFirestore.instance
          .collection("favourites")
          .doc(user.uid)
          .update({"$movieID": myNewList});
    });
  }

  // ignore: non_constant_identifier_names
  Future<void> SignInUser(
      String email, String password, BuildContext context) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .catchError((e) {
        if (e.toString().contains("The password is invalid"))
          showErrorDiaglog("Sign in Failed", "Wrong password", context);
        else if (e.toString().contains(
            "There is no user record corresponding to this identifier"))
          showErrorDiaglog("Sign in Failed", "Invalid email", context);
      });
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
