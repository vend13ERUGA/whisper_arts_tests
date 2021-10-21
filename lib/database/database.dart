import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:whisper_arts_tests/dataclass/database_data.dart';

class BasketFavourutesDatabase {
  static final BasketFavourutesDatabase instance =
      BasketFavourutesDatabase._init();

  static Database? _database;

  BasketFavourutesDatabase._init();

  Future<void> initDB(String filePath) async {
    if (_database == null) {
      final dbPath = await getDatabasesPath();
      final path = join(dbPath, filePath);
      _database = await openDatabase(path, version: 1, onCreate: _createDB);
    }
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $tableBasket ( 
  ${databaseFields.id} $idType, 
  ${databaseFields.idClock} $integerType,
  ${databaseFields.quantity} $integerType,
  ${databaseFields.name} $textType,
  ${databaseFields.url} $textType,
  ${databaseFields.description} $textType,
  ${databaseFields.price} $textType
  )
''');
    await db.execute('''
CREATE TABLE $tableFavourites (
  ${databaseFields.id} $idType,
  ${databaseFields.idClock} $integerType,
  ${databaseFields.quantity} $integerType,
  ${databaseFields.name} $textType,
  ${databaseFields.url} $textType,
  ${databaseFields.description} $textType,
  ${databaseFields.price} $textType
  )
''');
  }

  void incrementQuantity(DatabaseData? basket) {
    basket!.quantity++;
    update(basket);
  }

  void decrementQuantity(DatabaseData? basket) {
    if (basket!.quantity >= 2) {
      basket.quantity--;
    }
    update(basket);
  }

  Future<DatabaseData> create(DatabaseData basket, String tableName) async {
    final id = await _database!.insert(tableName, basket.toJson());
    return basket.copy(id: id);
  }

  // Future<DatabaseData> readBasket(int idClock) async {
  //   final maps = await _database!.query(
  //     tableBasket,
  //     columns: databaseFields.values,
  //     where: '${databaseFields.idClock} = ?',
  //     whereArgs: [idClock],
  //   );
  //   if (maps.isNotEmpty) {
  //     return DatabaseData.fromJson(maps.first);
  //   } else {
  //     throw Exception('ID $idClock not found');
  //   }
  // }

  Future<DatabaseData?> readBasket(int idClock) async {
    return await _database!.query(
      tableBasket,
      columns: databaseFields.values,
      where: '${databaseFields.idClock} = ?',
      whereArgs: [idClock],
    ).then((maps) => maps.isEmpty ? null : DatabaseData.fromJson(maps.first));
  }

  Future<List<DatabaseData>> readAll(String tableName) async {
    final result = await _database!.query(tableName);
    return result.map((json) => DatabaseData.fromJson(json)).toList();
  }

  Future<int> update(DatabaseData databaseData) {
    return _database!.update(
      tableBasket,
      databaseData.toJson(),
      where: '${databaseFields.id} = ?',
      whereArgs: [databaseData.id],
    );
  }

  Future<int> delete(int idClock, String tableName) async {
    return await _database!.delete(
      tableName,
      where: '${databaseFields.idClock} = ?',
      whereArgs: [idClock],
    );
  }

  Future deleteAll() async {
    await _database!.rawDelete("DELETE FROM $tableBasket");
  }

  void close() {
    _database!.close();
  }
}
