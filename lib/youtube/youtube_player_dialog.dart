import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/material.dart';

class YoutubePlayerDialog extends StatefulWidget {
  final String _videoUrl;
  YoutubePlayerDialog({Key key, String videoUrl})
      : _videoUrl = videoUrl,
        super(key: key);

  @override
  _YoutubePlayerDialogState createState() => _YoutubePlayerDialogState();
}

class _YoutubePlayerDialogState extends State<YoutubePlayerDialog> {
  String get videoUrl => widget._videoUrl;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: YoutubePlayer(
        context: context,
        videoId: videoUrl,
        flags: YoutubePlayerFlags(
          autoPlay: true,
          showVideoProgressIndicator: true,
        ),
      ),
    );
  }
}
