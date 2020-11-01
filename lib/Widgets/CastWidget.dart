import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const fontColor = TextStyle(color: Colors.white);

class CastWidget extends StatelessWidget {
  final String actor;
  final String actorImage;
  CastWidget({
    this.actor,
    this.actorImage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[500], width: 1),
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(actorImage),
            ),
          ),
        ),
        FittedBox(
          child: Text(
            actor,
            style: fontColor,
          ),
        )
      ],
    );
  }
}
