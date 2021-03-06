import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/Models/MovieCastModel.dart';
import 'dart:convert';
import 'dart:async';

import 'package:movies_app/Models/MovieModel.dart';

const apiKey = "dc8c6ae585c2496b758c84803cd3868e";

class MovieApi with ChangeNotifier {
  List<MovieModel> upComing = [];
  List<MovieModel> popular = [];
  List<MovieModel> topRated = [];
  List<MovieModel> recommend = [];
  List<MovieCastModel> movieCastModel = [];
  List<String> genereList = [];
  var duration;
  Future<String> duraion(int movieID) async {
    final response = await http.get(
        "https://api.themoviedb.org/3/movie/$movieID?api_key=$apiKey&language=en-US");
    final decodedResponse = jsonDecode(response.body);
    duration = decodedResponse["runtime"];
    int min = duration % 60;
    double hours = duration / 60;
    int hrs = hours.toInt();
    String result = "$hrs h $min mins";
    return result;
  }

  Future<void> movieCast(int movieId) async {
    final response = await http.get(
        "https://api.themoviedb.org/3/movie/$movieId/credits?api_key=$apiKey");
    final decodedReponse = jsonDecode((response.body));
    movieCastModel.clear();
    decodedReponse["cast"].forEach((actor) {
      if (response.statusCode == 200) {
        movieCastModel.add(MovieCastModel(
            actorImage:
                "https://image.tmdb.org/t/p/w500" + actor["profile_path"],
            actorName: actor["name"],
            actorNameInMovie: actor["character"]));
      }
    });
    notifyListeners();
  }

  Future<void> fetchGenere(int movieId) async {
    final response = await http.get(
        "https://api.themoviedb.org/3/movie/$movieId?api_key=$apiKey&language=en-US");
    final decodedReponse = jsonDecode((response.body));
    genereList.clear();
    decodedReponse["genres"].forEach((genere) {
      genereList.add(genere["name"]);
    });
    notifyListeners();
  }

  Future<String> fetchTrailerId(String movieID) async {
    final response = await http.get(
        "https://api.themoviedb.org/3/movie/$movieID/videos?api_key=$apiKey&language=en-US");
    final decodedResp = jsonDecode(response.body);
    return decodedResp["results"][0]["key"];
  }

  Future<void> fetchAll(int pageno) async {
    final response = await http.get(
        "https://api.themoviedb.org/3/movie/upcoming?api_key=$apiKey&language=en-US&page=$pageno");
    final decodedResponse = jsonDecode(response.body);
    upComing.clear();
    decodedResponse["results"].forEach((result) {
      if (response.statusCode == 200) {
        upComing.add(
          MovieModel(
            adult: result["adult"].toString(),
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
      }
      notifyListeners();
    });

    final response2 = await http.get(
        "https://api.themoviedb.org/3/movie/popular?api_key=$apiKey&language=en-US&page=$pageno");
    final decodedResponse2 = jsonDecode(response2.body);
    popular.clear();
    decodedResponse2["results"].forEach((result) {
      if (response2.statusCode == 200) {
        print(pageno);
        popular.add(
          MovieModel(
            adult: result["adult"].toString(),
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
      }
      notifyListeners();
    });

    final response3 = await http.get(
        "https://api.themoviedb.org/3/movie/top_rated?api_key=$apiKey&language=en-US&page=$pageno");
    final decodedResponse3 = jsonDecode(response3.body);
    topRated.clear();
    decodedResponse3["results"].forEach((result) {
      if (response3.statusCode == 200) {
        topRated.add(
          MovieModel(
            adult: result["adult"].toString(),
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
      }
      notifyListeners();
    });
  }

  Future<void> fetchRecommended(int movieId) async {
    final response = await http.get(
        "https://api.themoviedb.org/3/movie/$movieId/recommendations?api_key=$apiKey&language=en-US&page=1");
    final decodedResponse = jsonDecode(response.body);
    recommend.clear();
    decodedResponse["results"].forEach((result) {
      if (response.statusCode == 200) {
        recommend.add(
          MovieModel(
            adult: result["adult"].toString(),
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
      }
    });
  }
}
