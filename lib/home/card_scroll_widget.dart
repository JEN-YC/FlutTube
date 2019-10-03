import 'package:flutter/material.dart';
import 'dart:math';
import '../movie/movie.dart';

class CardScrollWidget extends StatelessWidget {
  final currentPage;
  final padding = 20.0;
  final verticalInset = 20.0;

  final MovieList _movieList;
  CardScrollWidget({this.currentPage, MovieList movieList})
      : _movieList = movieList;

  @override
  Widget build(BuildContext context) {
    var cardAspectRatio = 12.0 / 16.0;
    var widgetAspectRatio = cardAspectRatio * 1.2;

    return new AspectRatio(
      aspectRatio: widgetAspectRatio,
      child: LayoutBuilder(builder: (context, constraints) {
        var width = constraints.maxWidth;
        var height = constraints.maxHeight;

        var safeWidth = width - 2 * padding;
        var safeHeight = height - 2 * padding;

        var heightOfPrimaryCard = safeHeight;
        var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

        var primaryCardLeft = safeWidth - widthOfPrimaryCard;
        var horizontalInset = primaryCardLeft / 2;

        List<Widget> cardList = new List();

        for (var i = 0; i < _movieList.results.length; i++) {

          var delta = i - currentPage;
          bool isOnLeft = delta > 0;
          var start = padding +
              max(
                  primaryCardLeft - horizontalInset * -delta * (isOnLeft ? 15 : 1),
                  0.0);
          var cardItem = Positioned.directional(
            top: padding + verticalInset * max(-delta, 0.0),
            bottom: padding + verticalInset * max(-delta, 0.0),
            start: start,
            textDirection: TextDirection.rtl,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(3.0, 6.0),
                      blurRadius: 10.0)
                ]),
                child: AspectRatio(
                  aspectRatio: cardAspectRatio,
                  child: FadeInImage.assetNetwork(
                    image:
                    'https://image.tmdb.org/t/p/w185${_movieList.results[i].posterPath}',
                    placeholder: 'assets/no.jpg',
                    fit: BoxFit.fill,),
                ),
              ),
            ),
          );
          cardList.add(cardItem);
        }
        return Stack(
          children: cardList,
        );
      }),
    );
  }
}
