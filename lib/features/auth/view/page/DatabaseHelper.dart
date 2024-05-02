import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:the_quran/features/auth/view/page/home_page.dart';


class DatabaseHelper {
  static final _databaseName = "MyDatabase.db";
  static final _databaseVersion = 1;

  static final table = 'Profile';

  static final columnId = '_id';
  static final columnFirstName = 'firstName';
  static final columnLastName = 'lastName';
  static final columnBio = 'bio';
  static final columnFavoriteReciters = 'favoriteReciters';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnFirstName TEXT ,
            $columnLastName TEXT ,
            $columnBio TEXT ,
            $columnFavoriteReciters TEXT
          )
          ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  Future<Profile> getProfile(int id) async {
    Database db = await instance.database;

    List<Map> results = await db.query(table,
        where: '$columnId = ?',
        whereArgs: [id]);

    if (results.isNotEmpty) {
      return Profile.fromMap(results.first as Map<String, dynamic>);
    }
    return Profile(0, 'failed to retrieve', 'failed to retrieve', 'failed to retrieve', 'failed to retrieve');
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }
}