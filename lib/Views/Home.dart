import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:movies_app/Localizations/applocalization.dart';
import 'package:movies_app/Views/RegisterUi.dart';
import 'package:movies_app/Widgets/buttons.dart';

import 'LoginUi.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {

  Animation<double> _animationLogin;
  Animation<double> _animationMoveUp;
  Animation<double> _batmanIn;
  Animation<double> _buttonIn;
  AnimationController _animationController;
  void setFirstAnimations() {
    _animationController =
        AnimationController(vsync:this, duration: Duration(seconds: 3));
    _animationLogin = Tween(begin: 20.0, end: 1.0).animate(CurvedAnimation(
        curve: Interval(0.0, 0.25), parent: _animationController));
    // TODO: implement initState
    _animationMoveUp = CurvedAnimation(
        curve: Interval(0.15, 0.50), parent: _animationController);
    _batmanIn = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        curve: Interval(0.76, 0.9), parent: _animationController));
    _buttonIn = CurvedAnimation(
        curve: Interval(0.75, 0.9), parent: _animationController);
    _animationController.forward();
  }

  @override
  void initState() {
    setFirstAnimations();

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();

    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return GestureDetector(
      onTap: () {
        _animationController.forward(from: 0.0);
      },
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, _) {
          return Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/backgroundImage.jpg"))),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Transform.scale(
                      scale: _batmanIn.value,
                      child: Image.asset(
                        "assets/images/1.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: Get.height / 1.9 - 40 * _animationMoveUp.value,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Opacity(
                            opacity: _animationMoveUp.value,
                            child: Column(
                              children: [
                                Text(
                                  Applocalications.of(context)
                                      .translation("first_string"),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 22),
                                ),
                                FittedBox(
                                  child: Text(
                                      Applocalications.of(context)
                                          .translation("second_string"),
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 35)),
                                ),
                              ],
                            ),
                          ),
                          Transform.scale(
                            scale: (_animationLogin.value),
                            child: Hero(
                              tag: "logo",
                              child: Image.asset(
                                "assets/images/batman_logo.png",
                                width: 200,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                          Divider(),
                          Opacity(
                            opacity: _buttonIn.value,
                            child: Transform.translate(
                              offset: Offset(0.0, 100 * (1 - _buttonIn.value)),
                              child: Column(
                                children: [
                                  CustomButton(
                                    text: Applocalications.of(context)
                                        .translation("third_string"),
                                    onPressedd: () {         Get.to(Login());},
                                    isLeftSide: true,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  CustomButton(
                                    text: Applocalications.of(context)
                                        .translation("fourth_string"),
                                    onPressedd: () {
                                      Get.to(RegisterScreen());
                                    },
                                    isLeftSide: false,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
