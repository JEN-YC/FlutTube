import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:youtube_api/youtube_api.dart';

@immutable
abstract class YoutubeState extends Equatable {
  YoutubeState([List props = const []]) : super(props);
}

class YoutubeInitialState extends YoutubeState {
  @override
  String toString() => 'YoutubeInitialState';
}

class YoutubeLoadingState extends YoutubeState {
  @override
  String toString() => 'YoutubeLoadingState';
}

class YoutubeFailedState extends YoutubeState {
  @override
  String toString() => 'YoutubeFailedState';
}

class YoutubeSuccessState extends YoutubeState {
  final List<YT_API> ytResult;
  YoutubeSuccessState(this.ytResult) : super([ytResult]);
  @override
  String toString() => 'YoutubeSuccessState';
}