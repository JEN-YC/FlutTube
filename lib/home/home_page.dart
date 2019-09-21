import 'package:flutter/material.dart';
import '../authentication_bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttube/movie/movie.dart';
import 'show_movie_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MovieBloc _movieBloc;
  final MovieRepository _movieRepository = MovieRepository();
  int _selectIndex = 0;

  @override
  void initState() {
    _movieBloc = MovieBloc(movieRepository: _movieRepository);
    _movieBloc.dispatch(FetchTopRated(region: 'TW'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void _onTap(int index) {
      setState(() {
        _selectIndex = index;
      });

      switch (index) {
        case 0:
          _movieBloc.dispatch(FetchPopular(region: 'TW'));
          break;
        case 1:
          _movieBloc.dispatch(FetchNowPlaying(region: 'TW'));
          break;
        case 2:
          _movieBloc.dispatch(FetchTopRated(region: 'TW'));
          break;
      }
    }

    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
            Color(0xFF1b1e44),
            Color(0xFF2d3447),
          ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              tileMode: TileMode.clamp)),
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.star), title: Text('Popular')),
            BottomNavigationBarItem(
                icon: Icon(Icons.play_circle_filled),
                title: Text('Now Playing')),
            BottomNavigationBarItem(
                icon: Icon(Icons.thumb_up), title: Text('Top Rated')),
          ],
          backgroundColor: Colors.amberAccent,
          onTap: _onTap,
          currentIndex: _selectIndex,
        ),
        backgroundColor: Colors.transparent,
        body: BlocBuilder(
          bloc: _movieBloc,
          builder: (context, state) {
            if (state is LoadingMovie) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is InitMovieState) {
              return Center(
                child: Text('Init Movie'),
              );
            } else if (state is PopularMovieState) {
              return ShowMovieWidget(
                movieList: state.movieList,
                category: 'Popular',
              );
            } else if (state is NowPlayingMovieState) {
              return ShowMovieWidget(
                movieList: state.movieList,
                category: 'Now Playing',
              );
            } else if (state is TopRatedMovieState) {
              return ShowMovieWidget(
                movieList: state.movieList,
                category: 'Top Rated',
              );
            }
            return Center(
              child: Text('Failed'),
            );
          },
        ),
      ),
    );
  }
}