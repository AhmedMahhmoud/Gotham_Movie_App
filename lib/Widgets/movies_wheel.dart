import 'package:flutter/material.dart';

class MoviesWheel extends StatefulWidget {
  @override
  _MoviesWheelState createState() => _MoviesWheelState();
}

class _MoviesWheelState extends State<MoviesWheel> {
  PageController pageController = PageController(initialPage: 1 ,viewportFraction: 0.4);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.6,
      child: PageView.builder(
        controller: pageController,
        itemBuilder: (context, index) => Container(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://www.vintagemovieposters.co.uk/wp-content/uploads/2020/01/IMG_2893.jpeg'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Text(
                'Joker',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Montserrat-Bold',
                    fontSize: 20),
              ),
              Text(
                'genre: Action/Drama',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Montserrat',
                    fontSize: 12),
              )
            ],
          ),
        ),
      ),
    );
  }
}
