import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:the_quran/features/auth/model/reciter.dart';

import '../../auth/model/user_details.dart';

class DatabaseHelper {
  static const _databaseName = "MyDatabase.db";
  static const _databaseVersion = 1;

  static const usersTable = 'usersTable';
  static const columnUserId = 'userId';
  static const columnUserFullName = 'userFullName';
  static const columnUserBio = 'userBio';

  static const recitersTable = 'recitersTable';
  static const columnReciterId = 'reciterId';
  static const columnReciterName = 'reciterName';
  static const columnReciterStyle = 'reciterStyle';
  static const favouritesRecitersTable = 'favouritesReciters';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $usersTable (
        $columnUserId TEXT PRIMARY KEY,
        $columnUserFullName TEXT,
        $columnUserBio TEXT)
        ''');

    await db.execute('''
    CREATE TABLE $recitersTable (
      $columnReciterId INTEGER PRIMARY KEY,
      $columnReciterName TEXT,
      $columnReciterStyle TEXT)
    ''');

    await db.execute('''
    CREATE TABLE $favouritesRecitersTable (
        $columnUserId TEXT,
        $columnReciterId INTEGER, PRIMARY KEY($columnUserId, $columnReciterId),
        FOREIGN KEY ($columnUserId) REFERENCES $usersTable($columnUserId),
        FOREIGN KEY ($columnReciterId) REFERENCES $recitersTable($columnReciterId))
      ''');

    insertDefaultReciters();
  }

  void insertDefaultReciters() {
    insertReciter(Reciter(
      reciterId: 1,
      reciterName: 'Mishary Rashid Alafasy',
      reciterStyle: 'Mujawwad',
    ));
    insertReciter(Reciter(
      reciterId: 2,
      reciterName: 'Abdul Rahman Al-Sudais',
      reciterStyle: 'Murattal',
    ));
    insertReciter(Reciter(
      reciterId: 3,
      reciterName: 'Saad Al-Ghamdi',
      reciterStyle: 'Murattal',
    ));
    insertReciter(Reciter(
      reciterId: 4,
      reciterName: 'Abdullah Basfar',
      reciterStyle: 'Murattal',
    ));
    insertReciter(Reciter(
      reciterId: 5,
      reciterName: 'Abdul Basit Abdul Samad',
      reciterStyle: 'Murattal',
    ));
    insertReciter(Reciter(
      reciterId: 6,
      reciterName: 'Ahmed Al-Ajmi',
      reciterStyle: 'Murattal',
    ));
    insertReciter(Reciter(
      reciterId: 7,
      reciterName: 'Maher Al-Muaiqly',
      reciterStyle: 'Murattal',
    ));
    insertReciter(Reciter(
      reciterId: 8,
      reciterName: 'Saud Al-Shuraim',
      reciterStyle: 'Murattal',
    ));
    insertReciter(Reciter(
      reciterId: 9,
      reciterName: 'Yasser Al-Dosari',
      reciterStyle: 'Murattal',
    ));
    insertReciter(Reciter(
      reciterId: 10,
      reciterName: 'Nasser Al-Qatami',
      reciterStyle: 'Murattal',
    ));
  }

  Future<int> insertUserDetails(UserDetails userDetails) async =>
      (await instance.database).insert(usersTable, userDetails.toMap());

  Future<UserDetails> getUserDetails(String userId) async {
    Database db = await instance.database;
    List<Map> maps = await db
        .query(usersTable, where: '$columnUserId = ?', whereArgs: [userId]);

    if (maps.isNotEmpty) {
      UserDetails userDetails =
          UserDetails.fromMap(maps.first as Map<String, dynamic>);
      userDetails.favouriteReciters = await getUserFavouriteReciters(userId);
      return userDetails;
    }

    return UserDetails(
      userId: 'failed to retrieve',
      userFullName: 'failed to retrieve',
      userBio: 'failed to retrieve',
      favouriteReciters: List.empty(),
    );
  }

  Future<int> insertFavouriteReciter(String userId, int reciterId) async =>
      (await instance.database).insert(favouritesRecitersTable, {
        columnUserId: userId,
        columnReciterId: reciterId,
      });

  Future<int> deleteFavouriteReciter(String userId, int reciterId) async =>
      (await instance.database).delete(
        favouritesRecitersTable,
        where: '$columnUserId = ? AND $columnReciterId = ?',
        whereArgs: [userId, reciterId],
      );

  Future<int> insertReciter(Reciter reciter) async =>
      (await instance.database).insert(recitersTable, reciter.toMap());

  Future<List<Reciter>> getUserFavouriteReciters(String userId) async {
    Database db = await instance.database;
    List<Map> maps = await db.rawQuery(
      '''
          SELECT * FROM $favouritesRecitersTable
          INNER JOIN $recitersTable ON $favouritesRecitersTable.$columnReciterId = $recitersTable.$columnReciterId
          WHERE $favouritesRecitersTable.$columnUserId = ?
        ''',
      [userId],
    );

    return maps
        .map((map) => Reciter.fromMap(map as Map<String, dynamic>))
        .toList();
  }

  Future<List<Reciter>> getAllReciters() async {
    Database db = await instance.database;
    List<Map> maps = await db.query(recitersTable);
    return maps.isNotEmpty
        ? maps
            .map((map) => Reciter.fromMap(map as Map<String, dynamic>))
            .toList()
        : [];
  }
}
