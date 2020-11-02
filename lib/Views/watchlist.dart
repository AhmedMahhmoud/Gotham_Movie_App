import 'package:flutter/material.dart';
import 'package:movies_app/Services/MovieApi.dart';

class Watchlist_screen extends StatefulWidget {

  //Watchlist_screen({this.imageName, this.title});

  String imageName;
  String title;

  @override
  _Watchlist_screenState createState() => _Watchlist_screenState();
}

class _Watchlist_screenState extends State<Watchlist_screen> {

  List <MovieApi> watchlist = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Watchlist'),
        backgroundColor: Colors.black,
      ),
      body: Container(
          color: Colors.black,
          height: 300.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              BuildContainer(
                  imagename: 'images/avengers.jpg', title: 'Avengers'),
              BuildContainer(
                  imagename: 'images/age of ultron.jpg',
                  title: 'Avengers Age Of Ultron'),
              BuildContainer(
                  imagename: 'images/infinity war.jpg',
                  title: 'Avengers Infinity War'),
              BuildContainer(
                  imagename: 'images/endgame.jpg', title: 'Avengers End Game'),
            ],
          )),
    );
  }
}

class BuildContainer extends StatelessWidget {
  BuildContainer({this.imagename, this.title});

  String imagename;
  String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration:
          BoxDecoration(border: Border.all(color: Colors.white, width: 1)),
      width: 160.0,
      child: Card(
        color: Colors.yellow[700].withOpacity(0.6),
        child: Wrap(children: <Widget>[
          Image(
            image: AssetImage(imagename),
            fit: BoxFit.cover,
          ),
          ListTile(
            title: Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.grey[400]),
            ),
          ),
        ]),
      ),
    );
  }
}
