import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hawk_fab_menu/hawk_fab_menu.dart';
import 'package:flutter/material.dart';
import '../Views/FavouritesScreen.dart';

class MenuPopUp extends StatelessWidget {
  final Widget child;
  MenuPopUp(this.child);
  @override
  Widget build(BuildContext context) {
    return HawkFabMenu(
      fabColor: Colors.yellow[800],
      iconColor: Colors.black,
      items: [
        HawkFabMenuItem(
            label: "My Wachlist",
            ontap: () {
              Get.to(FavouritesScreen());
            },
            icon: Icon(
              Icons.favorite,
              color: Colors.red[800],
            ),
            color: Colors.white,
            labelColor: Colors.black),
        HawkFabMenuItem(
            label: "LogOut",
            ontap: () async {
              await FirebaseAuth.instance.signOut();
            },
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.black,
            ),
            color: Colors.white,
            labelColor: Colors.black),
      ],
      body: child,
    );
  }
}
