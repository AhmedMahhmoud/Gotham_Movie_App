import 'package:flutter/material.dart';

class TheTab extends StatefulWidget {
  final String tabName;
  const TheTab(this.tabName);
  @override
  _TheTabState createState() => _TheTabState();
}

class _TheTabState extends State<TheTab> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
          child: Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 0, 5),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            widget.tabName,
            style: TextStyle(
                fontSize: 30, fontFamily: 'Montserrat-Bold', color: Colors.white),
          ),
          Container(
            height: 5,
            width: 30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.yellow[800]),
          )
        ]),
      ),
    );
  }
}
