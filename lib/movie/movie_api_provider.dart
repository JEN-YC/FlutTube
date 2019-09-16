import 'package:http/http.dart';
import 'dart:async';
import 'dart:convert';
import 'model/movie_list.dart';

class MovieApiProvider{
  final Client _client = Client();
  final _apiKey = '980f1ede07f79d95165d87ce1c55ed16';
  final _baseUrl = 'http://api.themoviedb.org/3/movie';

  Future<MovieList> fetchPopularMovieList({String region='TW'}) async {
    final response = await _client.get(
      "$_baseUrl/popular?api_key=$_apiKey&page=1&region=$region");
    if (response.statusCode == 200) {
      return MovieList.fromJson(json.decode(response.body));
    }
    else {
      throw Exception('Failed to get popular movie list.');
    }
  }

  Future<MovieList> fetchNowPlayingMovieList({String region='TW'}) async {
    final response = await _client.get(
        "$_baseUrl/now_playing?api_key=$_apiKey&page=1&region=$region");
    if (response.statusCode == 200) {
      return MovieList.fromJson(json.decode(response.body));
    }
    else {
      throw Exception('Failed to get now playing movie list.');
    }
  }

  Future<MovieList> fetchTopRatedMovieList({String region='TW'}) async {
    final response = await _client.get(
        "$_baseUrl/top_rated?api_key=$_apiKey&page=1&region=$region");
    if (response.statusCode == 200) {
      return MovieList.fromJson(json.decode(response.body));
    }
    else {
      throw Exception('Failed to get top rated movie list.');
    }
  }
}