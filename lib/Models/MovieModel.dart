class MovieModel {
  String movieTitle;
  int movieId;
  String moviePoster;
  String movieReleaseDate;
  var movieRate;
  String movieSummary;
  String adult;
  String movieHorizontalPoster;
  List<dynamic> genere;

  MovieModel({
    this.adult,
    this.genere,
    this.movieHorizontalPoster,
    this.movieId,
    this.moviePoster,
    this.movieRate,
    this.movieReleaseDate,
    this.movieSummary,
    this.movieTitle,
  });

}
