import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:lottie/lottie.dart';
import 'package:movies_app/Models/MovieCastModel.dart';
import 'package:movies_app/Services/MovieApi.dart';
import 'package:movies_app/Views/watchlist.dart';
import 'package:movies_app/Widgets/CastWidget.dart';
import 'package:movies_app/Widgets/GenereMovieDetails.dart';
import 'package:movies_app/Widgets/TapMovieDetails.dart';
import 'package:provider/provider.dart';

const fontColor = TextStyle(color: Colors.white);

class MovieDetails extends StatelessWidget {
  final String movieSummary;
  final String movieName;
  final String releaseDate;
  var movieRate;
  final String moviePoster;
  final int movieID;
  final String isAdult;

  MovieDetails(
      {@required this.movieName,
      @required this.movieRate,
      @required this.movieSummary,
      @required this.releaseDate,
      @required this.movieID,
      @required this.isAdult,
      @required this.moviePoster});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder(
            future: Provider.of<MovieApi>(context, listen: false)
                .fetchGenere(movieID),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Lottie.asset("assets/lottie/batman.json"),
                );
              }
              final genereProvider =
                  Provider.of<MovieApi>(context, listen: false);
              return Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.3), BlendMode.dstIn),
                        image:
                            AssetImage("assets/images/backgroundImage.jpg"))),
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
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(50)),
                              child: Image(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(moviePoster)),
                            ),
                          ),
                          SizedBox(
                            height: 35,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 25, horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TitlesWithStyle(
                                      title: movieName,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          releaseDate,
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "2h 32 min",
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        Spacer(),
                                        Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: Color(0xffFF0000),
                                          ),
                                          height: 50,
                                          child: Row(
                                            children: [
                                              Text(
                                                "WATCH TRAILER",
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
                                Container(
                                  height: 50,
                                  child: ListView.builder(
                                    itemCount: genereProvider.genereList.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        margin: EdgeInsets.only(right: 20),
                                        child: GenereRow(
                                          text:
                                              genereProvider.genereList[index],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                TitlesWithStyle(
                                  title: "Plot Summary",
                                ),
                                Text(
                                  movieSummary,
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
                                FutureBuilder(
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                        child: Lottie.asset(
                                            "assets/lottie/batman.json"),
                                      );
                                    }
                                    final castProvider = Provider.of<MovieApi>(
                                        context,
                                        listen: false);
                                    if (castProvider.movieCastModel.length !=
                                        0) {
                                      return Container(
                                        height: Get.height / 4.743,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: castProvider
                                              .movieCastModel.length,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              margin:
                                                  EdgeInsets.only(right: 15),
                                              child: CastWidget(
                                                actor: castProvider
                                                    .movieCastModel[index]
                                                    .actorName,
                                                actorImage: castProvider
                                                    .movieCastModel[index]
                                                    .actorImage,
                                                actorInMoviename: castProvider
                                                    .movieCastModel[index]
                                                    .actorNameInMovie,
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    }
                                    return Text(
                                      "Cast not available .",
                                      style: fontColor,
                                    );
                                  },
                                  future: Provider.of<MovieApi>(context,listen: false)
                                      .movieCast(movieID),
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
                          padding: EdgeInsets.symmetric(
                              horizontal: 35, vertical: 15),
                          height: Get.height / 9.467,
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
                                firstText: " $movieRate /",
                                secondText: "10",
                                iconColor: Colors.yellow[600],
                              ),
                              TapDetails(
                                  fontAwesomeIcons: FontAwesomeIcons.heart,
                                  firstText: "Favourite ",
                                  secondText: "This",
                                  iconColor: Colors.red),
                              // RaisedButton(
                              //   onPressed: (){
                              //     Navigator.push(
                              //       context,
                              //       MaterialPageRoute(
                              //         builder: (context){
                              //           return Watchlist_screen(
                              //             imageName: moviePoster,
                              //             title: movieName,
                              //           );
                              //         }
                              //       )
                              //     );
                              //   }
                              // ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "+18",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  FaIcon(
                                    isAdult == "false"
                                        ? FontAwesomeIcons.times
                                        : FontAwesomeIcons.check,
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
              );
            }));
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
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
    );
  }
}
