import 'package:flutter/material.dart';
import '../youtube/youtube.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_api/youtube_api.dart';
import '../youtube/youtube_player_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timeago/timeago.dart' as timeago;

class MovieDetailPage extends StatefulWidget {
  final posterPath;
  final overview;
  final releaseDate;
  final title;
  final voteAverage;
  final movieId;

  MovieDetailPage(
      {Key key,
      this.posterPath,
      this.overview,
      this.releaseDate,
      this.title,
      this.voteAverage,
      this.movieId})
      : super(key: key);
  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  String get posterPath => widget.posterPath;
  String get overview => widget.overview;
  String get releaseDate => widget.releaseDate;
  String get title => widget.title;
  String get voteAverage => widget.voteAverage.toString();
  String get movieId => widget.movieId.toString();

  bool isOverviewSelected = false;
  YoutubeBloc _youtubeBloc;
  YoutubeRepository _youtubeRepository;
  Firestore _firestore;
  @override
  void initState() {
    _youtubeRepository = YoutubeRepository();
    _youtubeBloc = YoutubeBloc(youtubeRepository: _youtubeRepository);
    _youtubeBloc.dispatch(SearchYoutubeEvent("$title 預告片"));
    _firestore = Firestore.instance;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          top: false,
          bottom: false,
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  expandedHeight: 200.0,
                  floating: true,
                  elevation: 0.0,
                  flexibleSpace: FlexibleSpaceBar(
                      background: Image.network(
                    "https://image.tmdb.org/t/p/w500$posterPath",
                    fit: BoxFit.cover,
                  )),
                ),
              ];
            },
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(margin: EdgeInsets.only(top: 5.0)),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(margin: EdgeInsets.only(top: 8.0, bottom: 8.0)),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 1.0, right: 1.0),
                      ),
                      Text(
                        voteAverage,
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10.0, right: 50.0),
                      ),
                      Text(
                        "上映日期：$releaseDate",
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                  Container(margin: EdgeInsets.only(top: 8.0, bottom: 8.0)),
                  isOverviewSelected
                      ? GestureDetector(
                          onTap: () => setState(() {
                            isOverviewSelected = !isOverviewSelected;
                          }),
                          child: Text(overview),
                        )
                      : GestureDetector(
                          onTap: () => setState(() {
                            isOverviewSelected = !isOverviewSelected;
                          }),
                          child: Column(
                            children: <Widget>[
                              ConstrainedBox(
                                constraints: BoxConstraints(maxHeight: 200),
                                child: Text(
                                  overview,
                                  softWrap: true,
                                  overflow: TextOverflow.visible,
                                  maxLines: 2,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.arrow_drop_down),
                                  Text('閱讀全文'),
                                ],
                              )
                            ],
                          ),
                        ),
                  Container(margin: EdgeInsets.only(top: 8.0, bottom: 8.0)),
                  Text(
                    "Trailer",
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(margin: EdgeInsets.only(top: 8.0, bottom: 8.0)),
                  Flexible(
                    flex: 9,
                    child: BlocBuilder(
                      bloc: _youtubeBloc,
                      builder: (context, state) {
                        if (state is YoutubeSuccessState) {
                          return trailerLayout(state.ytResult);
                        }
                        return Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                  Container(margin: EdgeInsets.only(top: 8.0, bottom: 8.0)),
                  Text(
                    "Comments",
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Flexible(
                    flex: 4,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: Firestore.instance
                          .collection('comments')
                          .where("movie_id", isEqualTo: movieId)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData)
                          return const Text('There is no comment right now.');
                        final int commentCount = snapshot.data.documents.length;
                        if (commentCount > 0) {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: commentCount,
                            itemBuilder: (_, int index) {
                              final DocumentSnapshot document =
                                  snapshot.data.documents[index];
                              return commentWidget(
                                document['user_email'],
                                document['content'],
                                document['time'],
                              );
                            },
                          );
                        } else {
                          return Center(
                            child: Text(
                              'no comments...',
                              style: TextStyle(fontSize: 20),
                            ),
                          );
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}

Widget trailerLayout(List<YT_API> videos) {
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

Widget commentWidget(String email, String content, var time) {
  return Container(
      child: Column(
    children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            email,
            style: TextStyle(
                fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold),
          ),
          Text(
            timeago.format(time.toDate()),
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey,
            ),
          ),
        ],
      ),
      SizedBox(
        height: 10.0,
      ),
      Align(
        alignment: Alignment.topLeft,
        child: Text(
          content,
          style: TextStyle(fontSize: 16),
        ),
      ),
    ],
  ));
}
