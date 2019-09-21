class MovieList {
  int _page;
  int _totalResults;
  int _totalPages;
  List<_Item> _results = [];

  MovieList.fromJson(Map<String, dynamic> parsedJson) {
    _page = parsedJson['page'];
    _totalPages = parsedJson['total_pages'];
    _totalResults = parsedJson['total_results'];

    List<_Item> temp = [];
    for (int i = 0; i < parsedJson['results'].length; i++) {
      _Item item = _Item(parsedJson['results'][i]);
      temp.add(item);
    }
    _results = temp;
  }

  List<_Item> get results => _results;
  int get totalPages => _totalPages;
  int get totalResults => _totalResults;
  int get page => _page;

  @override
  String toString() {
    return '''MovieList {
      page: $page,
      totalPages: $totalPages,
      totalResult: $totalResults,
      results: ${results.toString()},
    }''';
  }
}

class _Item {
  var _popularity;
  int _voteCount;
  int _id;
  bool _video;
  var _voteAverage;
  String _title;
  String _posterPath;
  String _backdropPath;
  String _language;
  String _overview;
  String _releaseDate;

  _Item(result) {
    _popularity = result['popularity'].toString();
    _voteCount = result['vote_count'];
    _id = result['id'];
    _video = result['video'];
    _voteAverage = result['vote_average'] + 0.0;
    _title = result['original_title'];
    _posterPath = result['poster_path'];
    _backdropPath = result['backdrop_path'];
    _language = result['original_language'];
    _overview = result['overview'];
    _releaseDate = result['release_date'];
  }

  String get popularity => _popularity;
  int get voteCount => _voteCount;
  int get id => _id;
  bool get video => _video;
  double get voteAverage => _voteAverage;
  String get title => _title;
  String get posterPath => _posterPath;
  String get backdropPath => _backdropPath;
  String get language => _language;
  String get overview => _overview;
  String get releaseDate => _releaseDate;

  @override
  String toString(){
    return '''_Item{
      id: $id,
      title: $title,
      posterPath: $posterPath,
      overview: $overview
    }''';
  }
}
