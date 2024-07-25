import 'package:flower_store/models/cart.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _databaseService = DatabaseHelper._internal();
  factory DatabaseHelper() => _databaseService;
  DatabaseHelper._internal();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'db_cart.db');
    print("Đường dẫn database: $databasePath");
    return await openDatabase(
      path,
      onCreate: _onCreate,
      version: 2, // Increment the version number
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE Cart('
      'productID TEXT PRIMARY KEY, name TEXT, price FLOAT, img TEXT, address TEXT, des TEXT, date TEXT, quantity INTEGER)',
    );
  }

  Future<void> insertProduct(Cart productModel) async {
    final db = await _databaseService.database;
    await db.insert(
      'Cart',
      productModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Cart>> products() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query('Cart');
    return List.generate(maps.length, (index) => Cart.fromMap(maps[index]));
  }

  Future<Cart> product(String id) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps =
        await db.query('Cart', where: 'productID = ?', whereArgs: [id]);
    return Cart.fromMap(maps[0]);
  }

  Future<void> minus(Cart product) async {
    final db = await _databaseService.database;
    if (product.quantity > 1) {
      product.quantity--;
      await db.update(
        'Cart',
        product.toMap(),
        where: 'productID = ?',
        whereArgs: [product.productID],
      );
    } else {
      await db.delete(
        'Cart',
        where: 'productID = ?',
        whereArgs: [product.productID],
      );
    }
  }

  Future<void> add(Cart product) async {
    final db = await _databaseService.database;
    product.quantity++;
    await db.update(
      'Cart',
      product.toMap(),
      where: 'productID = ?',
      whereArgs: [product.productID],
    );
  }

  Future<void> deleteProduct(String id) async {
    final db = await _databaseService.database;
    await db.delete(
      'Cart',
      where: 'productID = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteProductAll() async {
    final db = await _databaseService.database;
    await db.delete('Cart');
  }

  Future<int> updateProduct(Cart cart) async {
    final db = await database;
    return await db.update(
      'Cart',
      cart.toMap(),
      where: 'productID = ?',
      whereArgs: [cart.productID],
    );
  }

  Future<void> clear() async {
    final db = await _databaseService.database;
    await db.delete('Cart', where: 'quantity > 0');
  }
}
