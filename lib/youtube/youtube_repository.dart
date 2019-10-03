import 'youtube_api_key.dart';
import 'package:youtube_api/youtube_api.dart';

class YoutubeRepository{
  final YoutubeAPI _youtubeAPI;

  YoutubeRepository({YoutubeAPI youtubeAPI})
    :_youtubeAPI = youtubeAPI ?? YoutubeAPI(youtube_api_key);

  Future<List> search({String keyWord}) async{
    return await _youtubeAPI.search(keyWord);
  }
}

