import '../movie/movie.dart';
import 'package:flutter/material.dart';
import 'card_scroll_widget.dart';

class ShowMovieWidget extends StatefulWidget {
  final MovieList _movieList;
  final String _category;
  ShowMovieWidget(
      {Key key, @required MovieList movieList, @override String category})
      : _movieList = movieList,
        _category = category,
        super(key: key);

  @override
  _ShowMovieWidgetState createState() => _ShowMovieWidgetState();
}

class _ShowMovieWidgetState extends State<ShowMovieWidget> {
  var currentPage;
  MovieList get movieList => widget._movieList;
  String get category => widget._category;

  @override
  void initState() {
    currentPage = movieList.results.length - 1.0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PageController controller =
    PageController(initialPage: movieList.results.length - 1);
    controller.addListener(() {
      setState(() {
        currentPage = controller.page;
      });
    });

    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
                left: 12.0, right: 12.0, top: 30.0, bottom: 8.0),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(category,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40.0,
                      fontFamily: "Calibre-Semibold",
                      letterSpacing: 1.0,
                    )),
                Align(
                  alignment: Alignment.centerRight,
                  child: Image.asset(
                    'assets/TMDb.png',
                    height: 40,
                  ),
                )
              ],
            ),
          ),
          Stack(
            children: <Widget>[
              CardScrollWidget(
                currentPage: currentPage,
                movieList: movieList,
              ),
              Positioned.fill(
                child: PageView.builder(
                  itemCount: movieList.results.length,
                  controller: controller,
                  reverse: true,
                  itemBuilder: (context, index) {
                    return Container();
                  },
                ),
              ),
            ],
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FittedBox(
                    child: Text(movieList.results[currentPage.round()].title,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 26.0,
                            fontFamily: "SF-Pro-Text-Bold")),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                      "上映日期：${movieList.results[currentPage.round()].releaseDate}",
                      style: TextStyle(
                          color: Colors.amberAccent,
                          fontSize: 10.0,
                          fontFamily: "SF-Pro-Text-Regular"))
                ],
              )),
        ],
      ),
    );
  }
}