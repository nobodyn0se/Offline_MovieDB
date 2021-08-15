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
