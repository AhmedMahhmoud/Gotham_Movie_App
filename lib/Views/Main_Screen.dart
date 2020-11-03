import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'package:movies_app/Services/MovieApi.dart';
import 'package:movies_app/Views/Movie_Details.dart';
import 'package:movies_app/Views/watchlist.dart';

import 'package:movies_app/Widgets/movies_wheel.dart';
import 'package:movies_app/Widgets/myWatchListButton.dart';
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
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: Provider.of<MovieApi>(context, listen: false).fetchAll(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Center(
                                        child: Lottie.asset(
                                            "assets/lottie/batman.json"),
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
                      background: CarouselSlider(
                    items: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(
                                'https://a-static.besthdwallpaper.com/the-dark-knight-rises-movie-poster-wallpaper-2560x1024-12624_99.jpg'),
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
                          onTap: () => Get.to(Watchlist_screen()),
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
