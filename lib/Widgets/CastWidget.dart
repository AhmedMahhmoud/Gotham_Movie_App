import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const fontColor = TextStyle(color: Colors.white);

class CastWidget extends StatelessWidget {
  final String actor;
  final String actorImage;
  final String actorInMoviename;
  CastWidget({
    this.actor,
    this.actorInMoviename,
    this.actorImage,
  });

  @override
  Widget build(BuildContext context) {
    return actor != ""
        ? Column(
            children: [
              Container(
                width: 80,
                height: MediaQuery.of(context).size.height / 8,
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
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                actorInMoviename,
                style: TextStyle(color: Colors.grey[600]),
              )
            ],
          )
        : Text("Not available");
  }
}
