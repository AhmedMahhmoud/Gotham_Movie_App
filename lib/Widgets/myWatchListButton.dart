import 'package:flutter/material.dart';

class MyWatchListButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'My watch list',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Montserrat-Bold',
              fontSize: 18,
            ),
          ),
          Icon(
            Icons.arrow_right_alt,
            color: Colors.yellow[800],
            size: 40,
          )
        ],
      ),
    );
  }
}
