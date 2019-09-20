import 'package:http/http.dart';
import 'dart:async';
import 'dart:convert';
import 'model/movie_list.dart';
import '../secret.dart';

class MovieApiProvider {
  final Client _client;
  String _apiKey;
  final _baseUrl = 'http://api.themoviedb.org/3/movie';
  MovieApiProvider({Client client})
      : _client = client ?? Client();

  Future<String> getKey() async {
    Secret secret =
        await SecretLoader(secretPath: 'assets/secrets.json').load();
    return secret.movieApiKey;
  }

  Future<MovieList> fetchPopularMovieList({String region = 'TW'}) async {
    _apiKey = _apiKey ?? await getKey();
    final response = await _client
        .get("$_baseUrl/popular?api_key=$_apiKey&page=1&region=$region");
    if (response.statusCode == 200) {
      return MovieList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to get popular movie list.');
    }
  }

  Future<MovieList> fetchNowPlayingMovieList({String region = 'TW'}) async {
    _apiKey = _apiKey ?? await getKey();
    final response = await _client
        .get("$_baseUrl/now_playing?api_key=$_apiKey&page=1&region=$region");
    if (response.statusCode == 200) {
      return MovieList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to get now playing movie list.');
    }
  }

  Future<MovieList> fetchTopRatedMovieList({String region = 'TW'}) async {
    _apiKey = _apiKey ?? await getKey();
    final response = await _client
        .get("$_baseUrl/top_rated?api_key=$_apiKey&page=1&region=$region");
    if (response.statusCode == 200) {
      return MovieList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to get top rated movie list.');
    }
  }
}
