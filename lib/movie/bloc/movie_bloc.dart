import 'dart:async';
import 'package:bloc/bloc.dart';
import '../movie.dart';
import 'package:meta/meta.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository _movieRepository;

  MovieBloc({@required MovieRepository movieRepository})
      : assert(movieRepository != null),
        _movieRepository = movieRepository;

  @override
  MovieState get initialState => InitMovieState();

  @override
  Stream<MovieState> mapEventToState(
    MovieEvent event,
  ) async* {
    if (event is FetchNowPlaying) {
      yield* _mapFetchNowPlayingToState(region: event.region);
    } else if (event is FetchPopular) {
      yield* _mapFetchPopularToState(region: event.region);
    } else if (event is FetchTopRated) {
      yield* _mapFetchTopRatedToState(region: event.region);
    }
  }

  Stream<MovieState> _mapFetchNowPlayingToState({String region}) async* {
    yield LoadingMovie();
    try {
      final _movieList =
          await _movieRepository.fetchNowPlayingMovieList(region: region);
      print(_movieList.results.length);
      yield NowPlayingMovieState(movieList: _movieList);
    } catch (_) {
      yield FailedFetchData();
    }
  }

  Stream<MovieState> _mapFetchPopularToState({String region}) async* {
    yield LoadingMovie();
    try {
      final _movieList =
          await _movieRepository.fetchPopularMovieList(region: region);
      yield PopularMovieState(movieList: _movieList);
    } catch (_) {
      yield FailedFetchData();
    }
  }

  Stream<MovieState> _mapFetchTopRatedToState({String region}) async* {
    yield LoadingMovie();
    try {
      final _movieList =
          await _movieRepository.fetchTopRatedMovieList(region: region);
      yield TopRatedMovieState(movieList: _movieList);
    } catch (_) {
      yield FailedFetchData();
    }
  }
}
