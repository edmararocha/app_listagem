// ignore_for_file: prefer_const_declarations, depend_on_referenced_packages, file_names, avoid_print

import 'dart:async';
import 'dart:io';

import 'package:app_listagem/src/models/PatientModel.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = "DBHelper.db";
  static final _databaseVersion = 1;

  static final table = "patients";

  static final columnId = "id";
  static final columnName = "name";
  static final columnEmail = "email";
  static final columnGender = "gender";
  static final columnAbout = "about";

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      print("db foi criado");
      return _database;
    }

    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future<FutureOr<void>> _onCreate(Database db, int version) async {
    print("foi inserido as informações");
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnName TEXT NOT NULL,
        $columnEmail TEXT NOT NULL,
        $columnGender TEXT NOT NULL,
        $columnAbout TEXT NOT NULL
      )
    ''');
  }

  Future<int> insert(PatientModel row) async {
    Database? db = await instance.database;
    return await db!.insert(table, row.toJson());
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database? db = await instance.database;
    return await db!.query(table);
  }

  Future<int?> queryRowCount() async {
    Database? db = await instance.database;
    return Sqflite.firstIntValue(
        await db!.rawQuery("SELECT COUNT(*) FROM $table"));
  }

  Future<int?> update(PatientModel row, int id) async {
    Database? db = await instance.database;
    return await db!
        .update(table, row.toJson(), where: "$columnId = ?", whereArgs: [id]);
  }

  Future<int?> delete(int id) async {
    Database? db = await instance.database;
    return await db!.delete(table, where: "$columnId = ?", whereArgs: [id]);
  }
}
