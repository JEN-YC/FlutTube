import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MovieEvent extends Equatable {
  MovieEvent([List props = const []]) : super(props);
}

class FetchNowPlaying extends MovieEvent {
  final String region;

  FetchNowPlaying({@required this.region}) : super([region]);

  @override
  String toString() {
    return "Fetch NowPlaying Movie List {region: $region}";
  }
}

class FetchPopular extends MovieEvent {
  final String region;

  FetchPopular({@required this.region}) : super([region]);

  @override
  String toString() {
    return "Fetch Popular Movie List {region: $region}";
  }
}

class FetchTopRated extends MovieEvent {
  final String region;

  FetchTopRated({@required this.region}) : super([region]);

  @override
  String toString() {
    return "Fetch TopRated Movie List {region: $region}";
  }
}

