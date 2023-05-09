import 'package:sqflite/sqflite.dart' as sql;
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:juicer/models/favlist.dart';

class DatabaseHelper {
  static Future<void> createTables(sql.Database database) async {
    print('created tables');
    await database.execute(
        """CREATE TABLE items(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    title TEXT,
    description TEXT) """);
  }

  static Future<sql.Database> db() async {
    print('created database');
    return sql.openDatabase(
      'Favorites.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<int> createItem(String title, String? description) async {
    final db = await DatabaseHelper.db();

    final data = {'title': title, 'description': description};
    final id = await db.insert('items', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    print(title);
    print(description);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await DatabaseHelper.db();
    return db.query('items', orderBy: "id");
  }
}
