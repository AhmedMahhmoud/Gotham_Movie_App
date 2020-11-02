import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:movies_app/Widgets/CastWidget.dart';
import 'package:movies_app/Widgets/GenereMovieDetails.dart';
import 'package:movies_app/Widgets/TapMovieDetails.dart';

const fontColor = TextStyle(color: Colors.white);

class MovieDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.3), BlendMode.dstIn),
                image: AssetImage("assets/images/backgroundImage.jpg"))),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: Get.width,
                    height: Get.height / 2.53,
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(50)),
                      child: Image(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                            "https://image.tmdb.org/t/p/w500/ugZW8ocsrfgI95pnQ7wrmKDxIe.jpg"),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 25, horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Column(
                              children: [
                                TitlesWithStyle(
                                  title: "HARD KILL",
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "2019",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "2h 32 min",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Spacer(),
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color(0xffFF0000),
                              ),
                              height: 50,
                              child: Row(
                                children: [
                                  Text(
                                    "WATCH TRAILER NOW",
                                    style: fontColor,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Center(
                                      child: FaIcon(
                                    FontAwesomeIcons.youtube,
                                    size: 34,
                                    color: Colors.white,
                                  )),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        TitlesWithStyle(
                          title: "GENRES",
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GenereRow(
                              text: "Action",
                            ),
                            GenereRow(
                              text: "Drama",
                            ),
                            GenereRow(
                              text: "Familly",
                            )
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TitlesWithStyle(
                          title: "Plot Summary",
                        ),
                        Text(
                          "Mercenaries race against the clock to stop a madman from using a computer program to wreak havoc around the globe.",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.grey,
                              letterSpacing: 1,
                              height: 1.4),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TitlesWithStyle(
                          title: "Cast & Crew",
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CastWidget(
                              actorImage:
                                  "https://www.gstatic.com/tv/thumb/persons/727254/727254_v9_bb.jpg",
                              actor: "Eva Marie",
                            ),
                            CastWidget(
                              actorImage:
                                  "https://cdn.britannica.com/48/194248-050-4EE825CF/Bruce-Willis-2013.jpg",
                              actor: "Bruce Willis",
                            ),
                            CastWidget(
                              actorImage:
                                  "https://img1.thelist.com/img/gallery/the-untold-truth-of-lala-kent/intro-1557850084.jpg",
                              actor: "Lala Kent ",
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 260,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 35, vertical: 15),
                  height: Get.height/9.467,
                  width: Get.width - 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 2,
                          color: Colors.yellow[600],
                          offset: Offset(0, 3))
                    ],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      bottomLeft: Radius.circular(40),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TapDetails(
                        fontAwesomeIcons: FontAwesomeIcons.solidStar,
                        firstText: " 8.2 /",
                        secondText: "10",
                        iconColor: Colors.yellow[600],
                      ),
                      TapDetails(
                          fontAwesomeIcons: FontAwesomeIcons.heart,
                          firstText: "Favourite ",
                          secondText: "This",
                          iconColor: Colors.red),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "+18",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          FaIcon(
                            FontAwesomeIcons.times,
                            color: Colors.red[700],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TitlesWithStyle extends StatelessWidget {
  final String title;
  const TitlesWithStyle({this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
    );
  }
}
