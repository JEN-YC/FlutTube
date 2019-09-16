import 'dart:async';
import 'movie_api_provider.dart';
import 'model/movie_list.dart';

class MovieRepository {
  final _movieApiProvider = MovieApiProvider();

  Future<MovieList> fetchPopularMovieList({String region = 'TW'}) =>
      _movieApiProvider.fetchPopularMovieList(region: region);

  Future<MovieList> fetchNowPlayingMovieList({String region = 'TW'}) =>
      _movieApiProvider.fetchNowPlayingMovieList(region: region);

  Future<MovieList> fetchTopRatedMovieList({String region = 'TW'}) =>
      _movieApiProvider.fetchTopRatedMovieList(region: region);
}
