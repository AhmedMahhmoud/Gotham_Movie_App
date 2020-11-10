import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:movies_app/Services/Firebase.dart';

import 'package:movies_app/Services/MovieApi.dart';
import 'package:movies_app/Widgets/menu.dart';

import 'package:movies_app/Widgets/movies_wheel.dart';

import 'package:movies_app/Widgets/searchButton.dart';
import 'package:provider/provider.dart';
import '../Widgets/thetab.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MainScreen extends StatefulWidget {
  var currentIndex = 0;
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    List<String> pages = ["1", "2", "3", "4", "5"];
    final uc = Provider.of<MovieApi>(context, listen: false).upComing;
    final pop = Provider.of<MovieApi>(context, listen: false).popular;
    final top = Provider.of<MovieApi>(context, listen: false).topRated;
    //final fav = Provider.of<FirebaseServices>(context, listen: true, ).myFavourites;

    void getIndex(int ind) {
      setState(() {
        widget.currentIndex = ind;
      });
    }

    return Scaffold(
        backgroundColor: Colors.black,
        body: MenuPopUp(
          FutureBuilder(
            future: Future.wait([
              Provider.of<MovieApi>(context, listen: false)
                  .fetchAll(widget.currentIndex + 1),
              Provider.of<FirebaseServices>(context).getFavMovies()
            ]),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: Center(
                  child: Lottie.asset("assets/lottie/batman.json"),
                ));
              }

              return SafeArea(
                child: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      backgroundColor: Colors.transparent,
                      pinned: false,
                      floating: false,
                      expandedHeight: 150,
                      flexibleSpace: FlexibleSpaceBar(
                          background: Stack(
                        fit: StackFit.expand,
                        children: [
                          CarouselSlider(
                            items: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        'https://assets.fontsinuse.com/static/use-media-items/27/26618/full-1500x693/567022b0/interstellar_ver6_xlg.jpeg?resolution=0'),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ],
                            options: CarouselOptions(
                              initialPage: 0,
                              viewportFraction: 1,
                              scrollDirection: Axis.vertical,
                              autoPlay: true,
                              enableInfiniteScroll: true,
                            ),
                          ),
                          Positioned(
                              bottom: 10, right: 10, child: SearchButton()),
                        ],
                      )),
                    ),
                    SliverList(
                        delegate: SliverChildListDelegate([
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TheTab('Popular'),
                          MoviesWheel(pop),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.06,
                          ),
                          TheTab('Top Rated'),
                          MoviesWheel(top),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.06,
                          ),
                          TheTab('Upcoming'),
                          MoviesWheel(uc),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 19,
                            child: Align(
                              alignment: Alignment.center,
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: pages.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.only(right: 15),
                                    child: InkWell(
                                      onTap: () => getIndex(index),
                                      child: Text(
                                        pages[index],
                                        style: widget.currentIndex == index
                                            ? TextStyle(
                                                color: Colors.yellow[800],
                                                fontWeight: FontWeight.bold)
                                            : TextStyle(color: Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ]))
                  ],
                ),
              );
            },
          ),
        ));
  }
}
