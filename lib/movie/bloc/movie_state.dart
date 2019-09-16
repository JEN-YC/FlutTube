import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MovieState extends Equatable {
  MovieState([List props = const []]) : super(props);
}

class NowPlayingMovieState extends MovieState {
  final movieList;
  NowPlayingMovieState({@required this.movieList}) : super([movieList]);

  @override
  String toString() {
    return "NowPlayingMovieState";
  }
}

class PopularMovieState extends MovieState {
  final movieList;
  PopularMovieState({@required this.movieList}) : super([movieList]);

  @override
  String toString() {
    return "PopularMovieState";
  }
}

class TopRatedMovieState extends MovieState {
  final movieList;
  TopRatedMovieState({@required this.movieList}) : super([movieList]);

  @override
  String toString() {
    return "TopRatedMovieState";
  }
}

class InitMovieState extends MovieState {
  @override
  String toString() {
    return "InitMovieState";
  }
}

class LoadingMovie extends MovieState {
  @override
  String toString() {
    return "LoadingMovie";
  }
}

class FailedFetchData extends MovieState {
  @override
  String toString() {
    return "FailedFetchData";
  }
}