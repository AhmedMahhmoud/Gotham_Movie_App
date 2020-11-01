import 'package:flutter/material.dart';

class Watchlist_screen extends StatefulWidget {

  @override
  _Watchlist_screenState createState() => _Watchlist_screenState();
}

class _Watchlist_screenState extends State<Watchlist_screen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 340.0,
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            BuildContainer(imagename: 'images/avengers.jpg',title: 'Avengers'),
            BuildContainer(imagename: 'images/age of ultron.jpg',title: 'Avengers Age Of Ultron'),
            BuildContainer(imagename: 'images/infinity war.jpg',title: 'Avengers Infinity War'),
            BuildContainer(imagename: 'images/endgame.jpg',title: 'Avengers End Game'),
            
          ],
        )
      ),
    );
  }
}

class BuildContainer extends StatelessWidget {

  BuildContainer({this.imagename,this.title});

  String imagename;
  String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160.0,
      child: Card(
        color: Colors.yellow[700].withOpacity(0.3),
        child: Wrap(
          children: <Widget> [
    Image(
      image: AssetImage(imagename),
    ),
    ListTile(  
      title: Text(title),
    ),
    
          ]
        ),
      ),
    );
  }
}
