import 'package:bergverse/app/database/sqlite/script.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Connection {
  static Database? _db;

  static Future<Database> get() async =>
    _db ??= await openDatabase(join(await getDatabasesPath(), 'banco'), 
    version: 1, 
    onCreate: (db, v) {
        db.execute(createTable);
      });
  
}
