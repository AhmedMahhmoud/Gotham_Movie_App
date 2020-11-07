import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:movies_app/Services/Firebase.dart';

import 'package:movies_app/Services/MovieApi.dart';

import 'FavouritesScreen.dart';

import 'package:movies_app/Widgets/movies_wheel.dart';
import 'package:movies_app/Widgets/myWatchListButton.dart';
import 'package:movies_app/Widgets/searchButton.dart';
import 'package:provider/provider.dart';
import '../Widgets/thetab.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final uc = Provider.of<MovieApi>(context, listen: false).upComing;
    final pop = Provider.of<MovieApi>(context, listen: false).popular;
    final top = Provider.of<MovieApi>(context, listen: false).topRated;
    //final fav = Provider.of<FirebaseServices>(context, listen: true, ).myFavourites;
    

    return Scaffold(
      floatingActionButton: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 30),
          child: FloatingActionButton(
              tooltip: "Logout",
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
              backgroundColor: Colors.yellow,
              child: Icon(
                Icons.exit_to_app,
                color: Colors.black,
              )),
        ),
      ),
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: Future.wait([
          Provider.of<MovieApi>(context, listen: false).fetchAll(),
          Provider.of<FirebaseServices>(context).getFavMovies()
        ]), //Provider.of<MovieApi>(context, listen: false).fetchAll(),
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
                      Positioned(bottom: 10, right: 10, child: SearchButton()),
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
                      InkWell(
                          onTap: () => Get.to(FavouritesScreen(pop)),
                          // onTap: (){
                          //   MaterialPageRoute(builder: (context){
                          //       return Watchlist_screen()
                          //     }
                          //   );
                          // },
                          child: MyWatchListButton())
                    ],
                  ),
                ]))
              ],
            ),
          );
        },
      ),
    );
  }
}
