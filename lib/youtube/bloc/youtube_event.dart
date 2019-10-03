import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class YoutubeEvent extends Equatable {
  YoutubeEvent([List props = const []]) : super(props);
}

class SearchYoutubeEvent extends YoutubeEvent {
  final keyWord;
  SearchYoutubeEvent(this.keyWord) : super([keyWord]);
  @override
  String toString() => 'Search $keyWord on Youtube';
}
