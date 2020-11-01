import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GenereRow extends StatelessWidget {
  final String text;
  const GenereRow({
    this.text,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      child: Text(
        text,
        style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 15,
            letterSpacing: 1),
        textAlign: TextAlign.center,
      ),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.yellow[700], width: 1),
          borderRadius: BorderRadius.circular(15)),
    );
  }
}
