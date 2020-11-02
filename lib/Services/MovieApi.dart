import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:movies_app/Models/MovieModel.dart';

const apiKey = "dc8c6ae585c2496b758c84803cd3868e";

class MovieApi with ChangeNotifier {
  List<MovieModel> upComing = [];
  List<MovieModel> popular = [];
  List<MovieModel> topRated = [];
  Future<void> fetchAll() async {
    final response = await http.get(
        "https://api.themoviedb.org/3/movie/upcoming?api_key=$apiKey&language=en-US&page=1");
    final decodedResponse = jsonDecode(response.body);
    upComing.clear();
    decodedResponse["results"].forEach((result) {
      if (response.statusCode == 200) {
        upComing.add(
          MovieModel(
            adult: result["adult"],
            genere: result["genre_ids"],
            movieHorizontalPoster: result["backdrop_path"],
            movieId: result["id"],
            movieRate: result["vote_average"],
            moviePoster:
                "https://image.tmdb.org/t/p/w500" + result["poster_path"],
            movieReleaseDate: result["release_date"],
            movieSummary: result["overview"],
            movieTitle: result["title"],
          ),
        );
        notifyListeners();
      }
    });

    final response2 = await http.get(
        "https://api.themoviedb.org/3/movie/popular?api_key=$apiKey&language=en-US&page=1");
    final decodedResponse2 = jsonDecode(response2.body);
    popular.clear();
    decodedResponse2["results"].forEach((result) {
      if (response2.statusCode == 200) {
        popular.add(
          MovieModel(
            adult: result["adult"],
            genere: result["genre_ids"],
            movieHorizontalPoster: result["backdrop_path"],
            movieId: result["id"],
            movieRate: result["vote_average"],
            moviePoster:
                "https://image.tmdb.org/t/p/w500" + result["poster_path"],
            movieReleaseDate: result["release_date"],
            movieSummary: result["overview"],
            movieTitle: result["title"],
          ),
        );
        notifyListeners();
      }
    });

    final response3 = await http.get(
        "https://api.themoviedb.org/3/movie/top_rated?api_key=$apiKey&language=en-US&page=1");
    final decodedResponse3 = jsonDecode(response3.body);
    topRated.clear();
    decodedResponse3["results"].forEach((result) {
      if (response3.statusCode == 200) {
        topRated.add(
          MovieModel(
            adult: result["adult"],
            genere: result["genre_ids"],
            movieHorizontalPoster: result["backdrop_path"],
            movieId: result["id"],
            movieRate: result["vote_average"],
            moviePoster:
                "https://image.tmdb.org/t/p/w500" + result["poster_path"],
            movieReleaseDate: result["release_date"],
            movieSummary: result["overview"],
            movieTitle: result["title"],
          ),
        );
        notifyListeners();
      }
    });
  }

  
}
