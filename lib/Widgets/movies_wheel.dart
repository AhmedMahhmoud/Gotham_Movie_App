import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/Models/MovieModel.dart';
import 'package:movies_app/Views/Movie_Details.dart';

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
    

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: AspectRatio(
        aspectRatio: 1.6,
        child: PageView.builder(
          itemCount: widget.movieModel.length,
          controller: pageController,
          itemBuilder: (context, index) => Container(
            child: GestureDetector(
              onTap: () {
                Get.to(MovieDetails(
                  isAdult: widget.movieModel[index].adult,
                  movieID: widget.movieModel[index].movieId,
                  movieName: widget.movieModel[index].movieTitle,
                  moviePoster: widget.movieModel[index].moviePoster,
                  movieRate: widget.movieModel[index].movieRate,
                  movieSummary: widget.movieModel[index].movieSummary,
                  releaseDate: widget.movieModel[index].movieReleaseDate,
                  
                ));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 12,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(
                              widget.movieModel[index].moviePoster),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      widget.movieModel[index].movieTitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Montserrat-Bold',
                          fontSize: 12),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      '★' + widget.movieModel[index].movieRate.toString(),
                      style: TextStyle(
                          color: Colors.yellow[800],
                          fontFamily: 'Montserrat',
                          fontSize: 12),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
