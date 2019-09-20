import 'dart:io';

import 'package:http/http.dart';
import 'package:fluttube/movie/movie_api_provider.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:fluttube/movie/model/movie_list.dart';
import 'dart:convert';

class MockClient extends Mock implements Client {}

void main() {
  MockClient client;
  MovieApiProvider movieApiProvider;
  final baseUrl = 'http://api.themoviedb.org/3/movie';
  var rawData = {"results": [{"popularity": 21.532, "vote_count": 0, "video": false, "poster_path": r"/relIJqmRexUeUXPq7pNfnb178qg.jpg", "id": 614017, "adult": false, "backdrop_path": r"/xtCjSzqGLhb0oEiclJUyDApQHR2.jpg", "original_language": "zh", "original_title": "返校", "genre_ids": [27], "title": "Detention", "vote_average": 0, "overview": "Set in Taiwan during the 'White Terror' period of martial law, a high school girl who awakens in an empty school, only to find that her entire community has been abandoned except for one other student. Soon they realize that they have entered a realm filled with vengeful spirits and hungry ghosts.", "release_date": "2019-09-20"},], "page": 1, "total_results": 12, "dates": {"maximum": "2019-09-25", "minimum": "2019-08-08"}, "total_pages": 1};

  setUp(() {
    client = MockClient();
    movieApiProvider = MovieApiProvider(client: client);
  });

  void stubGet(String url, Response response) {
    when(client.get(argThat(startsWith(url))))
        .thenAnswer((_) async => response);
  }

  group('Test call fetch nowPlayingMovieList API', () {
    test('Success fetch nowPlayingMovieList', () async {
      final expectResult = MovieList.fromJson(rawData);
      stubGet(
          "$baseUrl/now_playing?",
          Response(json.encode(rawData), 200, headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
          }));

      final result = await movieApiProvider.fetchNowPlayingMovieList();
      expect(result.toString(), expectResult.toString());
    });

    test('Fail to fetch nowPlayingMovieList API', () async {
      final expectResult = throwsException;

      stubGet("$baseUrl/now_playing?", Response("BAD DATA", 404));

      expect(movieApiProvider.fetchNowPlayingMovieList(), expectResult);
    });
  });

  group('Test call fetch popularMovieList API', () {
    test('Success fetch PopularMovieList', () async {
      final expectResult = MovieList.fromJson(rawData);
      stubGet(
          "$baseUrl/popular?",
          Response(json.encode(rawData), 200, headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
          }));

      final result = await movieApiProvider.fetchPopularMovieList();
      expect(result.toString(), expectResult.toString());
    });

    test('Fail to fetch popularMovieList API', () async {
      final expectResult = throwsException;

      stubGet("$baseUrl/popular?", Response("BAD DATA", 404));

      expect(movieApiProvider.fetchPopularMovieList(), expectResult);
    });
  });

  group('Test call fetch topRatedMovieList API', () {
    test('Success fetch topRatedMovieList', () async {
      final expectResult = MovieList.fromJson(rawData);
      stubGet(
          "$baseUrl/top_rated?",
          Response(json.encode(rawData), 200, headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
          }));

      final result = await movieApiProvider.fetchTopRatedMovieList();
      expect(result.toString(), expectResult.toString());
    });

    test('Fail to fetch topRatedMovieList API', () async {
      final expectResult = throwsException;

      stubGet("$baseUrl/top_rated?", Response("BAD DATA", 404));

      expect(movieApiProvider.fetchTopRatedMovieList(), expectResult);
    });
  });
}
