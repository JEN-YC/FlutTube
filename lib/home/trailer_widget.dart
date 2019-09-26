import 'package:flutter/material.dart';
import 'package:youtube_api/youtube_api.dart';
import '../youtube/youtube_player_dialog.dart';

Widget trailerWidget(List<YT_API> videos) {
  if (videos.length > 0) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: videos.length > 4 ? 4 : videos.length,
      gridDelegate:
      SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        return Column(
          children: <Widget>[
            GestureDetector(
              child: Image.network(videos[index].thumbnail['default']['url']),
              onTap: () => showDialog(
                  context: context,
                  builder: (context) => YoutubePlayerDialog(
                    videoUrl: videos[index].id,
                  )),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 130),
              child: Text(
                videos[index].title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        );
      },
    );
  } else {
    return Center(
      child: Text(
        '找尋不到影片...',
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
      ),
    );
  }
}
