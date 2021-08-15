import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:movies_database/dbmodel/dbModel.dart';

class MoviesDatabase {
  static final MoviesDatabase instance =
      MoviesDatabase._init(); //default constructor

  static Database? _database;

  MoviesDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('movies.db');
    return _database!;
  }

  Future<Database> _initDB(String path) async {
    final dPath = await getDatabasesPath();
    final stringPath = join(dPath, path);

    return await openDatabase(stringPath, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final boolType = 'BOOLEAN NOT NULL';
    final textType = 'TEXT NOT NULL';

    await db.execute(''' 
      CREATE TABLE $tableName (
        ${MovieTable.id} $idType,
        ${MovieTable.isWatched} $boolType,
        ${MovieTable.imagePath} $textType,
        ${MovieTable.movieName} $textType,
        ${MovieTable.director} $textType,
        ${MovieTable.time} $textType
      )
    ''');
  }

  Future<Movies> create(Movies movies) async {
    final db = await instance.database;
    final id = await db.insert(tableName, movies.toJson()); //get id
    return movies.copy(id: id);
  }

  Future<List<Movies>> getMoviesList() async {
    final db = await instance.database;

    final orderBy = '${MovieTable.time} DESC';
    final res = await db.query(tableName, orderBy: orderBy);
    return res.map((e) => Movies.fromJson(e)).toList();
  }

  Future<int> update(Movies movie) async {
    final db = await instance.database;

    return db.update(tableName, movie.toJson(),
        where: '${MovieTable.id} = ?', whereArgs: [movie.id]);
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableName,
      where: '${MovieTable.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    _database = null; //returns old instance otherwise
    db.close();
  }
}
