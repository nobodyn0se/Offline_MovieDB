final String tableName = 'movies';

class MovieTable {
  static final List<String> details = [
    id,
    isWatched,
    imagePath,
    movieName,
    director,
    time
  ];

  static final String id = '_id';
  static final String isWatched = 'isWatched';
  static final String imagePath = 'imagePath';
  static final String movieName = 'movieName';
  static final String director = 'director';
  static final String time = 'time';
}

class Movies {
  final int? id;
  final bool isWatched;
  final String imagePath;
  final String movieName;
  final String director;
  final DateTime time;

  Movies(
      {this.id,
      required this.isWatched,
      required this.imagePath,
      required this.movieName,
      required this.director,
      required this.time});


  static Movies fromJson(Map<String, Object?> json) => Movies(
      id: json[MovieTable.id] as int?,
      isWatched: json[MovieTable.isWatched] == 1,
      imagePath: json[MovieTable.imagePath] as String,
      movieName: json[MovieTable.movieName] as String,
      director: json[MovieTable.director] as String,
      time: DateTime.parse(json[MovieTable.time] as String));

  Map<String, Object?> toJson() => {
        MovieTable.id: id,
        MovieTable.isWatched: isWatched ? 1 : 0,
        MovieTable.imagePath: imagePath,
        MovieTable.movieName: movieName,
        MovieTable.director: director,
        MovieTable.time: time.toIso8601String(),
      };
}
