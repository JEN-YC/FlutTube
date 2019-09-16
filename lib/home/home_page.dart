import 'package:flutter/material.dart';
import '../authentication_bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttube/movie/movie.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () =>
            BlocProvider.of<AuthenticationBloc>(context).dispatch(LoggedOut()),
        label: Text("Logout"),
        icon: Icon(Icons.arrow_back),
      ),
      body: MovieList(),
    );
  }
}

class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  MovieBloc _movieBloc;
  final MovieRepository _movieRepository = MovieRepository();

  @override
  void initState() {
    _movieBloc = MovieBloc(movieRepository: _movieRepository);
    _movieBloc.dispatch(FetchPopular(region: 'TW'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _movieBloc,
      builder: (context, state) {
        if (state is LoadingMovie) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is FailedFetchData){
          return Center(child: Text('Failed'),);
        }else if (state is InitMovieState){
          return Center(child: Text('Init Movie'),);
        }
          return buildList(state.movieList);
      },
    );
  }
}

Widget buildList(movieList) {
  return GridView.builder(
      itemCount: movieList.results.length,
      gridDelegate:
          new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        return GridTile(
            child: InkResponse(
          enableFeedback: true,
          child: Image.network(
            'https://image.tmdb.org/t/p/w185${movieList.results[index].posterPath}',
            fit: BoxFit.cover,
          ),
        ));
      });
}
