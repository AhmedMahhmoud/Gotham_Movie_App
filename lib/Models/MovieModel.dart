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

  /*Future<String> fetchTrailer() async {
    String trailer;
    final http.Response response = await http.get(
        "https://api.themoviedb.org/3/movie/$movieId/videos?api_key=dc8c6ae585c2496b758c84803cd3868e&language=en-US");
    final decodedResponse = jsonDecode(response.body);
    decodedResponse["results"].forEach((result) {
      trailer = result["key"];
    });
    return "https://www.youtube.com/watch?v="+trailer;
  }*/
}
