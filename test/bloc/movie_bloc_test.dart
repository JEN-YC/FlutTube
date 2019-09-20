import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:fluttube/movie/movie.dart';

class MockMovieRepository extends Mock implements MovieRepository {}

void main() {
  MockMovieRepository movieRepository;
  MovieBloc movieBloc;

  setUp(() {
    movieRepository = MockMovieRepository();
    movieBloc = MovieBloc(movieRepository: movieRepository);
  });

  test('initial state is correct', () {
    expect(movieBloc.initialState, InitMovieState());
  });

  test('dispose does not emit new states', () {
    expectLater(
      movieBloc.state,
      emitsInOrder([]),
    );
    movieBloc.dispose();
  });

  group('Test NowPlayingMovieState Success and Fail condition', () {
    test('emits [InitMovieState, LoadingMovie, NowPlayingMovieState] for success FetchNowPlaying', () {
      var fakeData = {
        'page': 1,
        'total_pages': 10,
        'total_results': 100,
        'results': []
      };

      final expectedResponse = [
        InitMovieState().toString(),
        LoadingMovie().toString(),
        NowPlayingMovieState(movieList: MovieList.fromJson(fakeData)).toString()
      ];

      when(movieRepository.fetchNowPlayingMovieList(region: "TW"))
          .thenAnswer((_) => Future.value(MovieList.fromJson(fakeData)));

      expectLater(
        movieBloc.state.map((state) => state.toString()),
        emitsInOrder(expectedResponse),
      );

      movieBloc.dispatch(FetchNowPlaying(region: 'TW'));
    });

    test('emits [InitMovieState, LoadingMovie, FailedFetchData] for fail FetchNowPlaying', (){

      final expectedResponse = [
        InitMovieState(),
        LoadingMovie(),
        FailedFetchData(),
      ];

      when(movieRepository.fetchNowPlayingMovieList(region: "TW"))
          .thenThrow(Exception);

      expectLater(
        movieBloc.state,
        emitsInOrder(expectedResponse),
      );

      movieBloc.dispatch(FetchNowPlaying(region: 'TW'));
    });
  });

  group('Test PopularMovieState Success and Fail condition', () {
    test('emits [InitMovieState, LoadingMovie, PopularMovieState] for success FetchPopular', () {
      var fakeData = {
        'page': 1,
        'total_pages': 10,
        'total_results': 100,
        'results': []
      };

      final expectedResponse = [
        InitMovieState().toString(),
        LoadingMovie().toString(),
        PopularMovieState(movieList: MovieList.fromJson(fakeData)).toString()
      ];

      when(movieRepository.fetchPopularMovieList(region: "TW"))
          .thenAnswer((_) => Future.value(MovieList.fromJson(fakeData)));

      expectLater(
        movieBloc.state.map((state) => state.toString()),
        emitsInOrder(expectedResponse),
      );

      movieBloc.dispatch(FetchPopular(region: 'TW'));
    });

    test('emits [InitMovieState, LoadingMovie, FailedFetchData] for fail FetchPopular', (){

      final expectedResponse = [
        InitMovieState(),
        LoadingMovie(),
        FailedFetchData(),
      ];

      when(movieRepository.fetchPopularMovieList(region: "TW"))
          .thenThrow(Exception);

      expectLater(
        movieBloc.state,
        emitsInOrder(expectedResponse),
      );

      movieBloc.dispatch(FetchPopular(region: 'TW'));
    });
  });

  group('Test TopRatedMovieState Success and Fail condition', () {
    test('emits [InitMovieState, LoadingMovie, TopRatedMovieState] for success FetchTopRated', () {
      var fakeData = {
        'page': 1,
        'total_pages': 10,
        'total_results': 100,
        'results': []
      };

      final expectedResponse = [
        InitMovieState().toString(),
        LoadingMovie().toString(),
        TopRatedMovieState(movieList: MovieList.fromJson(fakeData)).toString()
      ];

      when(movieRepository.fetchTopRatedMovieList(region: "TW"))
          .thenAnswer((_) => Future.value(MovieList.fromJson(fakeData)));

      expectLater(
        movieBloc.state.map((state) => state.toString()),
        emitsInOrder(expectedResponse),
      );

      movieBloc.dispatch(FetchTopRated(region: 'TW'));
    });

    test('emits [InitMovieState, LoadingMovie, FailedFetchData] for fail FetchTopRated', (){

      final expectedResponse = [
        InitMovieState(),
        LoadingMovie(),
        FailedFetchData(),
      ];

      when(movieRepository.fetchTopRatedMovieList(region: "TW"))
          .thenThrow(Exception);

      expectLater(
        movieBloc.state,
        emitsInOrder(expectedResponse),
      );

      movieBloc.dispatch(FetchTopRated(region: 'TW'));
    });
  });
}
