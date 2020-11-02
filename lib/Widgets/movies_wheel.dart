import 'package:flutter/material.dart';
import 'package:movies_app/Models/MovieModel.dart';

class MoviesWheel extends StatefulWidget {
  List<MovieModel> movieModel;
  MoviesWheel(this.movieModel);
  @override
  _MoviesWheelState createState() => _MoviesWheelState();
}

class _MoviesWheelState extends State<MoviesWheel> {
  PageController pageController =
      PageController(initialPage: 1, viewportFraction: 0.4);

  @override
  Widget build(BuildContext context) {
    print(widget.movieModel[0].movieTitle);

    return AspectRatio(
      aspectRatio: 1.6,
      child: PageView.builder(
        itemCount: widget.movieModel.length,
        controller: pageController,
        itemBuilder: (context, index) => Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(widget.movieModel[index].moviePoster),
                    ),
                  ),
                ),
              ),
              Text(
                widget.movieModel[index].movieTitle,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Montserrat-Bold',
                    fontSize: 16),
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
