// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:movies_app/models/movie_item.dart';
import 'package:movies_app/screens/details_screen.dart';

class MovieProvider with ChangeNotifier {
  MovieProvider() {
    fetchMovies(1);
    fetchMovies(2);
    fetchMovies(3);
  }

  List<MovieItem> _topRatedMovie = [];
  List<MovieItem> get topRatedMovie {
    return [..._topRatedMovie];
  }

  int get topRatedMovieLength {
    return _topRatedMovie.length;
  }

  List<MovieItem> _trendMovie = [];
  List<MovieItem> get trendMovie {
    return [..._trendMovie];
  }

  List<MovieItem> _popularMovie = [];
  List<MovieItem> get popularMovie {
    return [..._popularMovie];
  }

  final List<MovieItem> _myMovies = [];
  List<MovieItem> get myMovies {
    return [..._myMovies];
  }

  Future<void> searchMovies(String title, BuildContext context) async {
    MovieItem isExisted = _myMovies.firstWhere(
      (movTitle) => movTitle.original_title == title,
    );
    if (isExisted.original_title == title) {
      String trailerKey = await getTrailer(isExisted.id);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailsScreen(
            trailerKey: trailerKey,
            imgUrl: isExisted.poster_path,
            title: title,
            overView: isExisted.overview,
          ),
        ),
      );
    }
  }

  Future<void> fetchMovies(int page) async {
    final movieUrl = Uri.parse(
      'https://api.themoviedb.org/3/movie/top_rated?api_key=e246526f831a94527aa2619dd2f0aa65&language=en-US&page=$page',
    );

    try {
      final movieRes = await http.get(movieUrl);

      final extractedMovieData = json.decode(movieRes.body)['results'];

      List<MovieItem> loadedMovies = [];

      if (extractedMovieData == null) {
        return;
      }

      for (var i in extractedMovieData) {
        loadedMovies.add(MovieItem.fromMap(i));
        _myMovies.add(MovieItem.fromMap(i));
      }

      if (page == 1) {
        _topRatedMovie = loadedMovies;
      }
      if (page == 2) {
        _trendMovie = loadedMovies;
      }
      if (page == 3) {
        _popularMovie = loadedMovies;
      }

      notifyListeners();
    } catch (er) {
      rethrow;
    }
  }

  Future<String> getTrailer(int id) async {
    final url = Uri.parse(
      'https://api.themoviedb.org/3/movie/$id/videos?api_key=e246526f831a94527aa2619dd2f0aa65&language=en-US',
    );

    try {
      final res = await http.get(url);
      final extractedData = json.decode(res.body)['results'][0]['key'];

      if (extractedData == null) {
        return 'null';
      }
      notifyListeners();
      return extractedData;
    } catch (er) {
      rethrow;
    }
  }
}
