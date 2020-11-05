import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TapDetails extends StatefulWidget {
  TapDetails({
    this.firstText,
    this.secondText,
    this.fontAwesomeIcons,
    this.iconColor,
    Key key,

  }) : super(key: key);

  IconData fontAwesomeIcons;
  String firstText;
  final String secondText;
  final Color iconColor;
  
  @override
  _TapDetailsState createState() => _TapDetailsState();
}

class _TapDetailsState extends State<TapDetails> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            if (widget.fontAwesomeIcons != FontAwesomeIcons.star &&
                widget.fontAwesomeIcons != FontAwesomeIcons.solidStar)
              setState(() {
                widget.fontAwesomeIcons == FontAwesomeIcons.heart
                    ? widget.fontAwesomeIcons = FontAwesomeIcons.solidHeart
                    : widget.fontAwesomeIcons = FontAwesomeIcons.heart;

                widget.firstText == "Favourite "
                    ? widget.firstText = "Unfavourite "
                    : widget.firstText = "Favourite ";
              });
          },
          child: FaIcon(
            widget.fontAwesomeIcons,
            color: widget.iconColor,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          children: [
            Text(widget.firstText,
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(widget.secondText,
                style: TextStyle(
                  color: Colors.grey[700],
                ))
          ],
        )
      ],
    );
  }
}
