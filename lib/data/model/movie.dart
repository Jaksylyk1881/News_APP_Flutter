class Movie{
  int _id;
  String _title;
  double _voteAverage;
  String _releaseDate;
  String _overview;
  String _posterPath;
  bool _isFav;

  Movie(this._id, this._title, this._voteAverage, this._releaseDate,
      this._overview, this._posterPath, this._isFav);

  String get posterPath => _posterPath;

  String get overview => _overview;

  String get releaseDate => _releaseDate;

  double get voteAverage => _voteAverage;

  String get title => _title;

  int get id => _id;

  bool get isFav => _isFav;


  set id(int value) {
    _id = value;
  }

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        json['id'] as int,
        json['title'] as String,
        json['vote_average'].toDouble() as double,
        json['release_date'] as String,
        json['overview'] as String,
        json['poster_path'] as String,
         false);
  }

  set title(String value) {
    _title = value;
  }

  set voteAverage(double value) {
    _voteAverage = value;
  }

  set releaseDate(String value) {
    _releaseDate = value;
  }

  set overview(String value) {
    _overview = value;
  }

  set posterPath(String value) {
    _posterPath = value;
  }

  set isFav(bool value) {
    _isFav = value;
  }
}