import 'package:flutter/material.dart';


class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key key, this.text, this.isLeftSide = true, this.onPressedd})
      : super(key: key);

  final VoidCallback onPressedd;
  final String text;
  final bool isLeftSide;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressedd,
      child: Container(
        height: 60,
        padding: EdgeInsets.all(15),
        color: Color(0xFFFDE86A),
        child: Stack(
          children: [
            if (isLeftSide)
              Align(
                alignment: Alignment.centerLeft,
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..translate(-10.0)
                    ..rotateZ(35),
                  child: Image.asset(
                    "assets/images/batman_logo.png",
                    height: 40,
                    fit: BoxFit.contain,
                    color: Color(0xFFC8B853),
                  ),
                ),
              ),
            Center(
              child: Text(
                text,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            if (!isLeftSide)
              Align(
                alignment: Alignment.centerRight,
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..translate(10.0)
                    ..rotateZ(35),
                  child: Image.asset(
                    "assets/images/batman_logo.png",
                    height: 40,
                    fit: BoxFit.contain,
                    color: Color(0xFFC8B853),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
