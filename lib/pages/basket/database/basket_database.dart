import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:whisper_arts_tests/dataclass/basket_database_data.dart';

class BasketDatabase {
  static final BasketDatabase instance = BasketDatabase._init();

  static Database? _database;

  BasketDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('basket.db');
    return _database!;
  }

  Future init() async {
    _database = await _initDB('basket.db');
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    print(path);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $tableBasket ( 
  ${BasketFields.id} $idType, 
  ${BasketFields.idClock} $integerType,
  ${BasketFields.quantity} $integerType,
  ${BasketFields.name} $textType,
  ${BasketFields.url} $textType,
  ${BasketFields.description} $textType,
  ${BasketFields.price} $textType

  )
''');
  }

  Future<void> incrementQuantity(BasketData basket) async {
    final db = await instance.database;
    basket.quantity++;
    update(basket);
  }

  Future<void> decrementQuantity(BasketData basket) async {
    final db = await instance.database;
    if (basket.quantity >= 2) {
      basket.quantity--;
    }
    update(basket);
  }

  Future<BasketData> create(BasketData basket) async {
    final db = await instance.database;
    final id = await db.insert(tableBasket, basket.toJson());
    return basket.copy(id: id);
  }

  Future<BasketData> readBasket(int idClock) async {
    final db = await instance.database;

    final maps = await db.query(
      tableBasket,
      columns: BasketFields.values,
      where: '${BasketFields.idClock} = ?',
      whereArgs: [idClock],
    );

    if (maps.isNotEmpty) {
      return BasketData.fromJson(maps.first);
    } else {
      throw Exception('ID $idClock not found');
    }
  }

  Future<List<BasketData>> readAllBasket() async {
    final db = await instance.database;
    final result = await db.query(tableBasket);
    return result.map((json) => BasketData.fromJson(json)).toList();
  }

  Future<int> update(BasketData basket) async {
    final db = await instance.database;

    return db.update(
      tableBasket,
      basket.toJson(),
      where: '${BasketFields.id} = ?',
      whereArgs: [basket.id],
    );
  }

  Future<int> delete(int idClock) async {
    final db = await instance.database;

    return await db.delete(
      tableBasket,
      where: '${BasketFields.idClock} = ?',
      whereArgs: [idClock],
    );
  }

  Future deleteAll() async {
    print("object");
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'basket.db');
    print(path);
    await deleteDatabase(path);
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
