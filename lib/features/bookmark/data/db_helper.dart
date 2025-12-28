import 'dart:io';
import 'package:bloge/features/bookmark/model/save_bookmark_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Dbhelper {
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database!;
    }
    // find path and create table
    Directory directory = await getApplicationDocumentsDirectory();

    String path = join(directory.path, 'mydatabase.db');
    // open db file create database table
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(''' 
    CREATE TABLE DatabaseTable(
    id INTEGER PRIMARY KEY,
    image TEXT,
    title TEXT,
    dics TEXT
    )''');
      },
    );
    return _database!;
  }

  // insert data to table
  Future<void> insertData(DataModel datamodel) async {
    final db = await database;
    await db!.insert('DatabaseTable', datamodel.toMap());
  }

  // read data
  Future<List<DataModel>> readData() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db!.query('DatabaseTable');
    return result.map((e) => DataModel.fromMap(e)).toList();
  }

  // delete data - ADDED THIS METHOD
  Future<void> deleteData(int id) async {
    final db = await database;
    await db!.delete('DatabaseTable', where: 'id = ?', whereArgs: [id]);
  }
}
