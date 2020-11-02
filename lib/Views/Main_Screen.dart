import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/Models/MovieModel.dart';
import 'package:movies_app/Screens/watchlist.dart';
import 'package:movies_app/Services/MovieApi.dart';

import 'package:movies_app/Widgets/movies_wheel.dart';
import 'package:movies_app/Widgets/myWatchListButton.dart';
import 'package:provider/provider.dart';
import '../Widgets/thetab.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'Movie_Details.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}



class _MainScreenState extends State<MainScreen> {
 
  @override
  Widget build(BuildContext context) { 
    final provider=Provider.of<MovieApi>(context,listen: false).upComing;
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: Provider.of<MovieApi>(context, listen: false).fetchUpcoming(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
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
                      MoviesWheel(provider),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
                      ),
                      TheTab('Top Rated'),
                      MoviesWheel(provider),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
                      ),
                      TheTab('Upcoming'),
                      MoviesWheel(provider),
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
