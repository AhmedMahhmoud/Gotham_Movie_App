import 'dart:ui';


import 'package:flutter/material.dart';


import 'package:movies_app/Widgets/SignUpButtons.dart';


const butColor = 0xFFFDE86A;

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  Animation<double> _buttonIn;
  AnimationController _animationController;
  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _buttonIn = CurvedAnimation(
        curve: Interval(0.75, 0.9), parent: _animationController);
    _animationController.forward();
   
    super.initState();
  }

  var futureValue;

  @override
  void dispose() {
    _animationController.dispose();
   
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Colors.black,
          body: SingleChildScrollView(
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, _) {
                return Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Hero(
                        tag: "logo",
                        child: Image(
                          width: 200,
                          image: AssetImage(
                            "assets/images/batman_logo.png",
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Center(
                        child: Text(
                      "GET ACCESS",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 3),
                    )),
                    SizedBox(
                      height: 50,
                    ),
                    Opacity(
                        opacity: _buttonIn.value,
                        child: Transform.translate(
                            offset: Offset(0.0, 100 * (1 - _buttonIn.value)),
                            child: SignUpButtons(
                              regOrLogin: "REGISTER",
                            ))),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
