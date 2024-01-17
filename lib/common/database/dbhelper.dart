import 'dart:async';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  static const _tableName = "favorite_restaurant";
  String columnId = "id";
  String columnName = "name";
  String columnAddress = "address";
  String columnRating = "rating";
  String columnImageUrl = "imgUrlId";

  Future<Database> initializeDatabase() async {
    var path = await getDatabasesPath();
    var database = openDatabase("$path/favoriterestaurants.db",
        version: 1, onCreate: _createDb);
    return database;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        '''CREATE TABLE $_tableName($columnId TEXT PRIMARY KEY, $columnName TEXT, $columnAddress TEXT, $columnRating REAL, $columnImageUrl TEXT )''');
  }

  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  Future<bool> isRestaurantFavorite(String id) async {
    Database db = await database;
    var result =
        await db.query(_tableName, where: "$columnId = ?", whereArgs: [id]);
    return result.isNotEmpty;
  }

  // Insert a restaurant into favorites
  Future<int> insertRestaurant(Map<String, dynamic> restaurant) async {
    Database db = await database;
    var result = await db.insert(_tableName, restaurant);
    return result;
  }

  Future<List<Map<String, dynamic>>> getRestaurants() async {
    Database db = await database;
    var result = await db.query(_tableName);
    return result;
  }

  Future<Map> getFavoriteRestaurantByID(String restaurantID) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db
        .query(_tableName, where: "$columnId = ?", whereArgs: [columnId]);

    if (result.isNotEmpty) {
      return result.first;
    } else {
      return {};
    }
  }

  // Delete a restaurant from favorites
  Future<void> deleteRestaurant(String id) async {
    final Database db = await database;
    await db.delete(
      _tableName,
      where: "$columnId = ?",
      whereArgs: [id],
    );
  }
}
