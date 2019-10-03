import 'dart:async';
import 'package:bloc/bloc.dart';
import '../youtube.dart';

class YoutubeBloc extends Bloc<YoutubeEvent, YoutubeState> {
  YoutubeRepository _youtubeRepository;
  YoutubeBloc({YoutubeRepository youtubeRepository})
      : assert(youtubeRepository != null),
        _youtubeRepository = youtubeRepository;

  @override
  YoutubeState get initialState => YoutubeInitialState();

  @override
  Stream<YoutubeState> mapEventToState(
    YoutubeEvent event,
  ) async* {
    if (event is SearchYoutubeEvent) {
      yield* _mapSearchToState(event.keyWord);
    }
  }

  Stream<YoutubeState> _mapSearchToState(String keyWord) async* {
    try {
      yield YoutubeLoadingState();
      final ytResult  = await _youtubeRepository.search(keyWord: keyWord);
      yield YoutubeSuccessState(ytResult);
    } catch (_) {
      yield YoutubeFailedState();
    }
  }
}
